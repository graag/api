from . import common
from .. import models, serializers

from django_filters import rest_framework
from rest_framework import generics, filters


class JobFilter(rest_framework.FilterSet):
    class Meta:
        model = models.Job
        fields = {
            'id': ['lt', 'gt'],
            'task': ['exact'],
            'exit_code': ['exact'],
            'job_status': ['exact'],
            'started_date': ['exact', 'gt', 'gte', 'lt', 'lte'],
            'completed_date': ['exact', 'gt', 'gte', 'lt', 'lte']
        }


class JobList(generics.ListAPIView):
    queryset = models.Job.objects.all()
    serializer_class = serializers.JobSerializer
    filter_backends = (
        rest_framework.DjangoFilterBackend,
        common.PETSearchFilter,
        filters.OrderingFilter,
    )
    filterset_class = JobFilter
    search_fields = ('job_status', 'job_description', 'job_params')
    ordering_fields = ('id',)
    ordering = ('-id',)
    pagination_class = common.PETPagination
