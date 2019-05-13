from . import common
from .. import models, serializers, permissions, authentication

from django_filters import rest_framework
from rest_framework import generics, filters, viewsets, decorators
from rest_framework.response import Response
from rest_framework import status

from datetime import datetime
from django.views.decorators.csrf import ensure_csrf_cookie


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
    serializer_class = serializers.EntityClientSerializer

    def get_object(self):
        return self.request.entity
