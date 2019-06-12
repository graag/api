from . import common
from .. import models, serializers, permissions

from django_filters import rest_framework
from rest_framework import filters, viewsets


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


class JobMixin:
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


class JobViewSet(viewsets.ModelViewSet):
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


class JobClientView(JobViewSet):
    permission_classes = (permissions.PETAuthPermission,)

    def get_queryset(self):
        return self.request.entity.authorizations.all()
