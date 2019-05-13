from django.urls import include, path
from django.contrib import admin
from django.contrib.auth import views as auth_views

from rest_framework import routers
from rest_framework_swagger.views import get_swagger_view

from . import views


admin_router = routers.SimpleRouter(
    trailing_slash=False
)

admin_router.register('entities', views.EntityViewSet)
admin_router.register('authorizations', views.AuthorizationViewSet)
admin_router.register('files', views.FileViewSet)
admin_router.register('jobs', views.JobViewSet)

schema_view = get_swagger_view(title='Pet API')

# fixes redirect in admin panel 'VIEW SITE'
admin.site.site_url = '/admin/entities'

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
]
