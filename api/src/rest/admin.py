from django.contrib import admin
from .models import (
    Authorization, Entity, Task, File, Job
)

# Register your models here.
for model in (Authorization, Entity, Task, File, Job):
    admin.site.register(model)
