from .models import Entity
from django.http import HttpResponse

class AuthMiddleware:

    HEADER_NAME = 'HTTP_CLIENT_CERT'

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        try:
            header = request.META[self.HEADER_NAME]
            raw_name = list(filter(
                lambda s: s.startswith('CN='), header.split(',')
            ))[0]
            common_name = raw_name[len('CN='):]

            entity = Entity.objects.get(common_name=common_name)
            request.entity = entity
        except Exception:
            # TODO: more specific exception handling
            # TODO: handle proper response to client
            request.entity = None
        return self.get_response(request)
