from . import views

from django.urls import path
from rest_framework import routers

router = routers.SimpleRouter()
router.register('entities', views.EntityViewSet)
router.register('authorizations', views.AuthorizationViewSet)
router.register('files', views.FileViewSet)
router.register('entity/files', views.FileClientViewSet)

urlpatterns = [
    # path('tasks', views.TaskListCreate.as_view()),
    # path('task/<int:pk>/files',views.ListTaskFiles.as_view(),),
    # path('task/<int:pk>/kill', views.TaskKillView.as_view()),
    # admin
    # path('authorizations', views.AuthorizationList.as_view()),
    # path('authorizations/<int:pk>', views.AuthorizationDetails.as_view()),
    # path('files', views.FileList.as_view()),
    # path('files/<int:pk>', views.FileDetails.as_view()),
    path('jobs', views.JobList.as_view()),
    # client
    path('entity', views.EntityClientView.as_view()),
    path('entity/authorizations', views.AuthorizationClientView.as_view()),
    # path('entity/files', views.FileClientView.as_view()),
    path('entity/jobs', views.JobClientView.as_view()),
    # path('entity/tasks', views.TaskClientView.as_view()),
    *router.urls,
]
