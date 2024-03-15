from django.urls import include, path

from config.urls.common import urlpatterns

urlpatterns += [
    path('__debug__/', include('debug_toolbar.urls')),
]
