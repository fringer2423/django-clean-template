include ENV/.env.common

build-prod: build-prod-balancer build-prod-main migrate collect-static
build-prod-no-migrate-static: build-prod-balancer build-prod-main
startapp:
	cd apps; python ../manage.py startapp --template=../config/app_template $(name)
restart-docker:
	sudo systemctl restart docker
build-prod-main:
	docker-compose -f docker-compose.prod.yml -p $(PROJECT_NAME) --env-file ENV/.env.docker.dev up -d --build --force-recreate
build-prod-balancer:
	docker-compose -f docker-compose.loadbalancer.yml -p $(PROJECT_NAME) --env-file ENV/.env.docker.dev up -d --build --force-recreate
migrate:
	docker exec backend python manage.py migrate
collect-static:
	docker exec backend python manage.py collectstatic --noinput
prod-up:
	docker-compose -f docker-compose.prod.yml -p $(PROJECT_NAME) --env-file ENV/.env.docker.dev up -d --build
prod-down-main:
	docker-compose -f docker-compose.prod.yml down
prod-down-balancer:
	docker-compose -f docker-compose.loadbalancer.yml down --remove-orphans
build-dev:
	docker-compose -f docker-compose.dev.yml -p $(PROJECT_NAME) --env-file ENV/.env.docker.dev up -d --build
dev-down:
	docker-compose -f docker-compose.dev.yml 