from django.contrib import admin

from .models import Models


for model in Models:
    admin.site.register(model.value, model.value.ModelAdmin)
