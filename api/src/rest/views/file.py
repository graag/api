from . import common
from .. import models, serializers

from django_filters import rest_framework
from rest_framework import generics, filters


class FileFilter(rest_framework.FilterSet):
    class Meta:
        model = models.File
        fields = {
            'id': ['lt', 'gt'],
            'task': ['exact'],
            'name': ['exact'],
            'comments': ['exact'],
            'path': ['exact'],
            'destination_job': ['exact'],
            'source_job': ['exact'],
        }


class FileList(generics.ListCreateAPIView):
    queryset = models.File.objects.all()
    serializer_class = serializers.FileSerializer
    filter_backends = (
        rest_framework.DjangoFilterBackend,
        common.PETSearchFilter,
        filters.OrderingFilter,
    )
    filterset_class = FileFilter
    search_fields = ('name', 'comments', 'path')
    ordering_fields = ('id',)
    ordering = ('-id',)
    pagination_class = common.PETPagination


class FileDetails(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.File.objects.all()
    serializer_class = serializers.FileSerializer
