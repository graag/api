from .. import models

from rest_framework import serializers


class EntitySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Entity
        fields = '__all__'
