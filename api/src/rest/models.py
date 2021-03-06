from django.db import models
from django.db.models.signals import pre_delete
from django.dispatch import receiver


class Authorization(models.Model):
    subject = models.CharField(max_length=45)

    fingerprint = models.CharField(max_length=45)

    start_date = models.DateTimeField()
    expiry_date = models.DateTimeField()
    timestamp = models.DateTimeField(auto_now_add=True)

    entity = models.ForeignKey(
        to='Entity', on_delete=models.CASCADE, related_name='authorizations'
    )


class EntityManager(models.Manager):

    def getEntity(self, name):
        return self.get(common_name=name)


class Entity(models.Model):

    common_name = models.CharField(max_length=45, unique=True)

    name = models.CharField(max_length=45)
    address = models.CharField(max_length=45)
    contact = models.CharField(max_length=45)
    comments = models.TextField(null=True)

    timestamp = models.DateTimeField(auto_now_add=True)

    objects = EntityManager()


class Task(models.Model):

    task_status = models.CharField(max_length=45, default='CREATING')

    started_date = models.DateTimeField(null=True)
    completed_date = models.DateTimeField(null=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    priority = models.IntegerField(default=1)
    parameters = models.CharField(max_length=45, null=True)
    comments = models.TextField(null=True, default=None)

    task_type = models.CharField(max_length=45, null=True, default=None)

    log_file = models.OneToOneField(
        to='File', on_delete=models.SET_NULL, blank=True,
        null=True, default=None, related_name='log_of_task'
    )

    entity = models.ForeignKey(
        to='Entity', on_delete=models.CASCADE, related_name='tasks'
    )


class File(models.Model):

    name = models.CharField(max_length=45)
    comments = models.CharField(max_length=45, null=True, default=None)
    path = models.CharField(max_length=45, null=True, default=None)
    task = models.ForeignKey(
        to='Task', on_delete=models.CASCADE, related_name='files'
    )


class Job(models.Model):

    saved_id = models.IntegerField(null=True, default=None)

    job_status = models.CharField(max_length=45, default='CREATING')

    started_date = models.DateTimeField(null=True)
    completed_date = models.DateTimeField(null=True)

    job_description = models.CharField(max_length=45, null=True, default=None)
    job_params = models.CharField(max_length=45, null=True, default=None)

    job_previous = models.ManyToManyField(
        to='Job', related_name='job_next', default=None
    )

    input_data = models.ManyToManyField(
        to='File', related_name='destination_task', blank=True
    )
    output_data = models.ManyToManyField(
        to='File', related_name='source_task', blank=True
    )

    out_file = models.OneToOneField(
        to='File', on_delete=models.SET_NULL, blank=True,
        null=True, default=None, related_name='out_of_job'
    )
    err_file = models.OneToOneField(
        to='File', on_delete=models.SET_NULL, blank=True,
        null=True, default=None, related_name='err_of_job'
    )

    exit_code = models.IntegerField(null=True, default=True)
    task = models.ForeignKey(
        to='Task', on_delete=models.CASCADE, related_name='jobs'
    )


@receiver(pre_delete, sender=Job)
def clear_logs(sender, instance, using, **kwargs):
    if instance.err_file is not None:
        instance.err_file.delete()
    if instance.out_file is not None:
        instance.out_file.delete()
