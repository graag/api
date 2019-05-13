from .. import models

from rest_framework import serializers


class EntitySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Entity
        fields = '__all__'


class EntityClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Entity
        exclude = ('id',)
