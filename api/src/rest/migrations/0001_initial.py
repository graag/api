# Generated by Django 2.2 on 2019-04-11 22:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Entity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('common_name', models.CharField(max_length=45, unique=True)),
                ('name', models.CharField(max_length=45)),
                ('address', models.CharField(max_length=45)),
                ('contact', models.CharField(max_length=45)),
                ('comments', models.TextField(null=True)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='File',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=45)),
                ('comments', models.CharField(default=None, max_length=45, null=True)),
                ('path', models.CharField(default=None, max_length=45, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('task_status', models.CharField(default='CREATING', max_length=45)),
                ('started_date', models.DateTimeField(null=True)),
                ('completed_date', models.DateTimeField(null=True)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('priority', models.IntegerField(default=1)),
                ('parameters', models.CharField(max_length=45, null=True)),
                ('comments', models.TextField(default=None, null=True)),
                ('task_type', models.CharField(default=None, max_length=45, null=True)),
                ('entity', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='tasks', to='rest.Entity')),
                ('log_file', models.OneToOneField(blank=True, default=None, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='log_of_task', to='rest.File')),
            ],
        ),
        migrations.CreateModel(
            name='Job',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('saved_id', models.IntegerField(default=None, null=True)),
                ('job_status', models.CharField(default='CREATING', max_length=45)),
                ('started_date', models.DateTimeField(null=True)),
                ('completed_date', models.DateTimeField(null=True)),
                ('job_description', models.CharField(default=None, max_length=45, null=True)),
                ('job_params', models.CharField(default=None, max_length=45, null=True)),
                ('exit_code', models.IntegerField(default=True, null=True)),
                ('err_file', models.OneToOneField(blank=True, default=None, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='err_of_job', to='rest.File')),
                ('input_data', models.ManyToManyField(blank=True, related_name='destination_job', to='rest.File')),
                ('job_previous', models.ManyToManyField(default=None, related_name='job_next', to='rest.Job')),
                ('out_file', models.OneToOneField(blank=True, default=None, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='out_of_job', to='rest.File')),
                ('output_data', models.ManyToManyField(blank=True, related_name='source_job', to='rest.File')),
                ('task', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='jobs', to='rest.Task')),
            ],
        ),
        migrations.AddField(
            model_name='file',
            name='task',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='files', to='rest.Task'),
        ),
        migrations.CreateModel(
            name='Authorization',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('subject', models.CharField(max_length=45)),
                ('fingerprint', models.CharField(max_length=74)),
                ('start_date', models.DateTimeField()),
                ('expiry_date', models.DateTimeField()),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('entity', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='authorizations', to='rest.Entity')),
            ],
        ),
    ]