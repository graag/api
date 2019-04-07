from . import job, file
from .. import models

from rest_framework import serializers


class TaskSerializer(serializers.ModelSerializer):
    jobs = job.JobSerializer(many=True, read_only=True)
    files = file.FileSerializer(many=True, read_only=True)
    log_file = file.FileSerializer(read_only=True)

    class Meta:
        model = models.Task
        fields = '__all__'
        read_only_fields = (
            'issued_date', 'started_date', 'completed_date',
            'task_status', 'jobs', 'files', 'log_file'
        )
        extra_kwargs = {
            'entity': {'write_only': True},
        }
