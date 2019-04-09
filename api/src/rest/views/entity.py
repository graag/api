from . import common
from .. import models, serializers, permissions
from rest_framework import generics
from django_filters import rest_framework
from rest_framework import filters
from rest_framework import viewsets


class EntityFilter(rest_framework.FilterSet):
    class Meta:
        model = models.Entity
        fields = {
            'id': ['lt', 'gt'],
            'common_name': ['exact'],
            'name': ['exact'],
            'address': ['exact'],
            'timestamp': ['exact', 'gt', 'gte', 'lt', 'lte']
        }


class EntityViewSet(viewsets.ModelViewSet):
    # permission_classes = (permissions.AdminPermission,)
    queryset = models.Entity.objects.all()
    serializer_class = serializers.EntitySerializer
    filter_backends = (
        rest_framework.DjangoFilterBackend,
        common.PETSearchFilter,
        filters.OrderingFilter,
    )
    filterset_class = EntityFilter
    search_fields = ('common_name', 'name', 'address')
    ordering_fields = ('id', 'timestamp')
    ordering = ('-id',)
    pagination_class = common.PETPagination


class EntityClientView(generics.RetrieveAPIView):
    permission_classes = (permissions.ClientPermission,)
    serializer_class = serializers.EntitySerializer

    def get_object(self):
        return self.request.entity
