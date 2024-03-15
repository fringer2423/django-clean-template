try:
    from config.settings.common import *  # noqa: F401 F403
except ImportError as e:
    print(f'Import error {e}')

DEBUG = False

ROOT_URLCONF = 'config.urls.prod'
