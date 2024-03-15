import os

from celery import Celery

app = Celery('core')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()

app.conf.timezone = os.environ.get('TIMEZONE', default='UTC')
