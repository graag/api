from . import views

from django.urls import path

urlpatterns = [
    # path('tasks', views.TaskListCreate.as_view()),
    # path('task/<int:pk>/files',views.ListTaskFiles.as_view(),),
    # path('task/<int:pk>/kill', views.TaskKillView.as_view()),
    # admin
    path('entities', views.EntityList.as_view()),
    path('entities/<int:pk>', views.EntityDetails.as_view()),
    path('authorizations', views.AuthorizationList.as_view()),
    path('authorizations/<int:pk>', views.AuthorizationDetails.as_view()),
    path('files', views.FileList.as_view()),
    path('files/<int:pk>', views.FileDetails.as_view()),
    path('jobs', views.JobList.as_view()),
    # client
    path('entity', views.EntityClientView.as_view()),
    path('entity/authorizations', views.AuthorizationClientView.as_view()),
]
