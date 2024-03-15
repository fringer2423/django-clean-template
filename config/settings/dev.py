import mimetypes
import socket

try:
    from config.settings.common import *  # noqa: F401 F403
except ImportError as e:
    print(f'Import error {e}')

DEBUG = True

INSTALLED_APPS += [  # noqa: F405
    'debug_toolbar',
]

MIDDLEWARE += [  # noqa: F405
    'debug_toolbar.middleware.DebugToolbarMiddleware',
]

ROOT_URLCONF = 'config.urls.dev'

INTERNAL_IPS = [
    '127.0.0.1',
]

mimetypes.add_type("application/javascript", ".js", True)


hostname, _, ips = socket.gethostbyname_ex(socket.gethostname())
INTERNAL_IPS = [ip[: ip.rfind(".")] + ".1" for ip in ips] + ["127.0.0.1", "10.0.2.2"]
