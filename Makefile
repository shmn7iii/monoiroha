DOCKER_COMPOSE=./compose.yml

docker/up:
	docker compose -f $(DOCKER_COMPOSE) up -d --build
	docker compose exec rails bin/setup

docker/start:
	docker compose -f $(DOCKER_COMPOSE) start

docker/stop:
	docker compose -f $(DOCKER_COMPOSE) stop

docker/down:
	docker compose -f $(DOCKER_COMPOSE) down --volumes

docker/logs:
	docker compose logs -f

rails/migrate:
	docker compose exec rails bin/rails db:migrate
	docker compose exec rails bin/bundle exec bin/rails ridgepole:apply

rails/console:
	docker compose exec rails bin/rails console

rails/reset:
	docker compose exec rails bin/rails db:drop
	docker compose exec rails bin/rails db:create
	docker compose exec rails bin/rails db:migrate
	docker compose exec rails bin/bundle exec bin/rails ridgepole:apply
	docker compose exec rails bin/rails db:seed
	docker compose exec rails bin/rails restart

prod:
	DOCKER_COMPOSE=./compose.production.yml

prod/docker/up: prod
	docker compose -f $(DOCKER_COMPOSE) up -d --build
	docker compose exec rails bin/setup

prod/docker/start: prod
	docker compose -f $(DOCKER_COMPOSE) start

prod/docker/stop: prod
	docker compose -f $(DOCKER_COMPOSE) stop

prod/docker/down: prod
	docker compose -f $(DOCKER_COMPOSE) down --volumes
