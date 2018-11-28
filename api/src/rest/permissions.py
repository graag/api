from rest_framework import permissions


class IsPetPermission(permissions.BasePermission):
    """
    Check if pet is in database.
    """
    message = 'Bad PETNAME. No PET associated with this name.'

    def has_permission(self, request, view):
        print('PERMISSION', request.entity)
        return request.entity is not None
