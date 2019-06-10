from .. import models, serializers, permissions

from rest_framework import generics, mixins, exceptions
from rest_framework.response import Response


class TaskList(generics.ListAPIView):
    serializer_class = serializers.TaskSerializer
    queryset = models.Task.objects.all()


class TaskListCreate(generics.GenericAPIView, mixins.ListModelMixin):
    serializer_class = serializers.TaskSerializer
    permission_classes = (permissions.PETAuthPermission,)

    def get_queryset(self):
        queryset = self.request.entity.tasks.all()
        return queryset

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        # Split task, jobs and files data
        task_data = request.data
        task_data['entity'] = str(self.request.entity.id)

        jobs_data = task_data.pop('jobs', [])
        files_data = task_data.pop('files', [])

        # Creating Task
        task_serializer = serializers.TaskSerializer(data=task_data)
        if not task_serializer.is_valid():
            raise exceptions.ParseError(detail=task_serializer.errors)

        task_object = task_serializer.save()

        # Creating Files
        file_name_id_map = dict()

        for file_data in files_data:

            file_data['task'] = task_object.id
            file_serializer = serializers.FileSerializer(data=file_data)

            if not file_serializer.is_valid():
                task_object.task_status = 'ERROR'
                task_object.save()
                raise exceptions.ParseError(detail=file_serializer.errors)

            file_object = file_serializer.save()
            file_object.path = str(task_object.entity.id) + '/' \
                + str(task_object.id) + '/' \
                + str(file_object.id)
            file_object.save()

            # Check File name uniqueness and update name <-> ID map
            if file_object.name not in file_name_id_map:
                file_name_id_map[file_object.name] = file_object.id
            else:
                task_object.task_status = 'ERROR'
                task_object.save()
                raise exceptions.ParseError(
                    detail='Duplicated file name ' + str(file_object.name)
                )

        # Creating Jobs
        # Function mapping file name to it's id, it uses file_name_id_map,
        # throws Exception if name is not specified
        def mapper(file_name):
            if file_name in file_name_id_map:
                return file_name_id_map[file_name]
            else:
                task_object.task_status = 'ERROR'
                task_object.save()
                raise exceptions.ParseError(
                    detail='File name specified in Job but not in files section: ' + file_name
                )

        job_objects = []

        for job_data in jobs_data:
            job_data['task'] = task_object.id
            job_previous_data = job_data.get('job_previous', [])
            if 'input_data' in job_data:
                mapped_input_data = list(map(mapper, job_data['input_data']))
                job_data['input_data'] = mapped_input_data

            if 'output_data' in job_data:
                mapped_output_data = list(map(mapper, job_data['output_data']))
                job_data['output_data'] = mapped_output_data

            # To this point job_data has mapped input/output data tables.
            # Info about previous jobs is in job_previous_data list

            job_serializer = serializers.JobSerializer(data=job_data)
            if not job_serializer.is_valid():
                task_object.task_status = 'ERROR'
                task_object.save()
                raise exceptions.ParseError(detail=job_serializer.errors)

            job_object = job_serializer.save()
            job_objects.append((job_object, job_previous_data))

        for job, job_previous_list in job_objects:
            for previous in job_previous_list:
                job.job_previous.add(task_object.jobs.get(
                    saved_id=int(previous)
                ))
            job.job_status = 'CREATED'
            job.save()

        task_object.task_status = 'CREATED'
        task_object.save()

        return Response(
            data=serializers.TaskSerializer(task_object).data, status=200
        )
