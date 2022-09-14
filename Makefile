DOCKER_COMPOSE=./compose.yml

docker/up:
	docker compose -f $(DOCKER_COMPOSE) up -d --build

docker/start:
	docker compose -f $(DOCKER_COMPOSE) start

docker/stop:
	docker compose -f $(DOCKER_COMPOSE) stop

docker/down:
	docker compose -f $(DOCKER_COMPOSE) down --volumes

docker/logs:
	docker compose logs -f

rails/migrate:
	docker compose exec rails rails db:migrate
	docker compose exec rails bundle exec rails ridgepole:apply

rails/console:
	docker compose exec rails rails console
