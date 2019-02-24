from django.urls import path
from . import views
from . import test_views

urlpatterns = [
    path('entities', views.EntityCAView.as_view()),
    path('test', test_views.index),
]
