from django.conf import settings
from django.contrib import admin

from apps.core.models.admins.UserModelAdmin import UserModelAdmin
from apps.core.models.UserModel import User

from .models import Models

admin.site.register(User, UserModelAdmin)

for model in Models:
    admin.site.register(model.value, model.value.ModelAdmin)

admin.site.site_title = settings.PROJECT_NAME
admin.site.site_header = f'Администрирование {settings.PROJECT_NAME}'
admin.site.index_title = 'Панель администрирования'
