from .. import models

from rest_framework import serializers


class FileSerializer(serializers.ModelSerializer):
    '''Serializes to: id, name, comments, path'''
    class Meta:
        model = models.File
        fields = '__all__'
