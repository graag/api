from rest_framework import serializers
from .. import models


class AuthorizationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Authorization
        fields = '__all__'


class AuthorizationClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Authorization
        exclude = ('entity',)
