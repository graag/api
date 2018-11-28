from django.urls import path
from . import views
from . import test_views

urlpatterns = [
    path('test', test_views.index),
    path('entity', views.EntityView.as_view()),
    path('tasks', views.TaskListCreate.as_view()),

    path(
        'task/<int:pk>/files',
        views.ListTaskFiles.as_view(),
        kwargs={'type': None}
    ),
    path(
        'task/<int:pk>/input_files',
        views.ListTaskFiles.as_view(),
        kwargs={'type': 'input'}
    ),
    path(
        'task/<int:pk>/output_files',
        views.ListTaskFiles.as_view(),
        kwargs={'type': 'output'}
    ),

    path('task/<int:pk>/status', views.TaskStatusView.as_view()),
    path('task/<int:pk>/log', views.TaskLogView.as_view()),
    path('task/<int:pk>/kill', views.TaskKillView.as_view()),


    path('authorizations', views.AuthorizationView.as_view()),
    path('authorizations/active', views.AuthorizationActiveView.as_view()),
]
