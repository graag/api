from rest_framework import permissions


class PETAuthPermission(permissions.BasePermission):
    TYPE = None

    def has_permission(self, request, view):
        if request.auth == self.TYPE:
            return True
        return False


class ClientPermission(PETAuthPermission):
    TYPE = 'client'


class AdminPermission(PETAuthPermission):
    TYPE = 'admin'
