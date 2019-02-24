from .. import models, serializers, permissions
from rest_framework import generics
from . import common
from rest_framework.generics import get_object_or_404


class EntityView(generics.RetrieveAPIView):
    serializer_class = serializers.EntitySerializer
    permission_classes =(permissions.IsPetPermission,)

    def get(self, *args, **kwargs):
        print('ENTITY GET')
        return super().get(*args, **kwargs)

    def get_object(self):
        obj = self.request.entity
        return obj


class EntityCAView(generics.ListAPIView):
    queryset = models.Entity.objects.all()
    serializer_class = serializers.EntityBasicSerializer


class EntityByCN(generics.RetrieveAPIView):
    serializer_class = serializers.EntityBasicSerializer

    def get_object(self):
        queryset = models.Entity.objects.all()
        obj = get_object_or_404(queryset, common_name=self.kwargs['cn'])
        return obj


class EntityCARetrieveView(generics.RetrieveAPIView):
    queryset = models.Entity.objects.all()
    serializer_class = serializers.EntityBasicSerializer

class EntityCAAuthsView(generics.ListCreateAPIView):
    serializer_class = serializers.AuthorizationLSerializer

    def get_queryset(self):
        lookup_url_kwarg = self.lookup_url_kwarg or self.lookup_field
        filter_kwargs = {self.lookup_field: self.kwargs[lookup_url_kwarg]}
        obj = get_object_or_404(models.Entity.objects.all(), **filter_kwargs)
        queryset = obj.authorizations
        return queryset


class EntityRUDView(generics.RetrieveUpdateDestroyAPIView, common.PermissionMixin):
    queryset = models.Entity.objects.all()
    serializer_class = serializers.EntityBasicSerializer


class EntityPETView(generics.RetrieveAPIView, common.PermissionMixin):
    serializer_class = serializers.EntityBasicSerializer

    def get_object(self):
        name = self.request.META.get('HTTP_PETNAME', None)
        entity = models.Entity.objects.getEntity(name)
        return entity
