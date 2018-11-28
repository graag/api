from ..permissions import IsPetPermission


class PermissionMixin():
    permission_classes = (IsPetPermission,)
