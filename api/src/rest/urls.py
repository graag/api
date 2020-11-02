from django.urls import include, path
from django.contrib import admin
from django.contrib.auth import views as auth_views

from rest_framework import routers
from rest_framework_swagger.views import get_swagger_view

from . import views

admin_router = routers.SimpleRouter(
    trailing_slash=False
)

admin_routes = {
    'entities': views.EntityViewSet,
    'authorizations': views.AdminAuthorizationViewSet,
    'files': views.FileViewSet,
    'jobs': views.JobViewSet,
    'tasks': views.TaskViewSet
}

for endpoint, view in admin_routes.items():
    admin_router.register(endpoint, view)


schema_view = get_swagger_view(title='Pet API')

# fixes redirect in admin panel 'VIEW SITE'
admin.site.site_url = '/admin/entities'

client_router = routers.SimpleRouter(
    trailing_slash=False
)
client_router.register(
    'authorizations',
    views.ClientAuthorizationViewSet,
    basename='authorizations'
)

urlpatterns = [
    path('admin/', include(admin_router.urls)),
    path(
        'admin/login',
        auth_views.LoginView.as_view(template_name='admin/login.html'),
        name='admin-login'
    ),
    path('admin/logout', auth_views.LogoutView.as_view(), name='admin-logout'),
    path('admin/schema', schema_view, name='api-schema'),
    path('admin/panel', admin.site.urls),
    # Client views
    path('client/entity', views.EntityClientView.as_view()),
    path('client/', include(client_router.urls)),
]
