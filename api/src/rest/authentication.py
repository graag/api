from .models import Entity

from rest_framework import authentication
from rest_framework import exceptions


class PETAuthentication(authentication.BaseAuthentication):
    HEADER_NAME = 'HTTP_CLIENT_CERT'

    def authenticate(self, request):
        entity_name = request.META.get('HTTP_CLIENT_CERT')
        if (entity_name):
            header = request.META[self.HEADER_NAME]
            raw_name = list(filter(
                lambda s: s.startswith('CN='), header.split(',')
            ))[0]
            common_name = raw_name[len('CN='):]
            try:
                entity = Entity.objects.get(common_name=common_name)
            except Exception:
                raise exceptions.AuthenticationFailed('No such entity.')
            request.entity = entity
            print(entity)
            return (None, True)
        return None  # try session auth
