from rest_framework import permissions


class IsPetPermission(permissions.BasePermission):
    """
    Check if pet is in database.
    """
    message = 'Bad PETNAME. No PET associated with this name.'

    def has_permission(self, request, view):
        return request.entity is not None


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
