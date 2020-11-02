from rest_framework import permissions


class PETAuthPermission(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        # Instance must have an attribute named `entity`.
        entity = getattr(request, 'entity', None)
        return entity and (obj == entity or obj.entity == entity)
