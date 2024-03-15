# Django clean template
===================================
## Описание

Проект создан для упрощения создания новых проектов на основе Django

## Стек

- [Django 5.0.3](https://docs.djangoproject.com/en/5.0/)
- [Celery](https://docs.celeryq.dev/en/stable/)
- [Redis](https://redis.io/docs/)
- [DRF](https://www.django-rest-framework.org/)
- [Flower](https://flower.readthedocs.io/en/latest/)
- [Docker](https://docs.docker.com/)
- [Make](https://www.gnu.org/software/make/manual/make.html)
- [Traefik](https://doc.traefik.io/traefik/)

## Подготовка 

### Make

Для полноценной работы с шаблоном, нужно установить [Make](https://www.gnu.org/software/make/manual/make.html)

Для mac os (Необходим [Homebrew](https://brew.sh/))
```
❯ brew install make
```

### Docker и Docker compose

Читаем [тут](https://docs.docker.com/engine/install/)

Для Mac OS рекомендую [OrbStack](https://orbstack.dev/)

### Редактор кода

- Добавлен небольшой конфиг для [VS Code](https://code.visualstudio.com/)

Рекомендуемые плагины:
- <code>isort</code>
- <code>Flake8</code>

### ENV

На основе примеров создаем свои файлы env:
- [env.common](ENV/.env.common.example) 
- [env.dev](ENV/.env.dev.example)
- [env.docker.dev](ENV/.env.docker.dev.example) 
- [env.docker.prod](ENV/.env.docker.prod.example) 
- [env.prod](ENV/.env.prod.example)

Для удобства поддержки и разделения конфигураций они разбиты на части.

### Проверка

Проверим, что мы все установили для работы с шаблоном 

```
❯ docker -v
Docker version 25.0.3, build 4debf41
```
```
❯ docker-compose -v
Docker Compose version v2.23.3
```
```
❯ make -v
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for i386-apple-darwin11.3.0
```

### Команды для работы с проектом

Все они описаны в [Makefile](Makefile)

#### build-prod

```
❯ make build-prod
```
Запустит сборку проекта для размещения на сервере.

- Запустит traefik [config](docker-compose.loadbalancer.yml)
- Основу проекта [config](docker-compose.prod.yml)
- Проведет миграции (Без [makemigrations](https://docs.djangoproject.com/en/5.0/ref/django-admin/#django-admin-makemigrations))
- Соберет статику

```
❯ docker-compose -f docker-compose.loadbalancer.yml -p $(PROJECT_NAME) --env-file ENV/.env.docker.dev up -d --build --force-recreate
...
❯ docker-compose -f docker-compose.prod.yml -p $(PROJECT_NAME) --env-file ENV/.env.docker.dev up -d --build --force-recreate
...
❯ docker exec backend python manage.py migrate
...
❯ docker exec backend python manage.py collectstatic --noinput
...
```

#### build-prod-no-migrate-static
```
❯ make build-prod-no-migrate-static
```

Запустит проект для размещения на сервере без проведения миграций и сбора статики

#### build-dev
```
❯ make build-dev
```
Запустит проект в <code>dev</code> режиме

#### startapp
```
❯ make startapp name={app}
```
Создает новое приложение в <code>apps</code> с указанным названием


