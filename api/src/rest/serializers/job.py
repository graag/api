from .. import models

from rest_framework import serializers


class JobSerializer(serializers.ModelSerializer):
    job_next = serializers.PrimaryKeyRelatedField(many=True, read_only=True)

    class Meta:
        model = models.Job
        fields = ('__all__')
