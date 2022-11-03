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

prod/docker/setup:
	docker compose -f ./compose.production.yml up -d --build
	docker compose exec rails bin/setup
	docker compose -f ./compose.production.yml stop
	echo '==========================='
	echo ''
	echo 'Setup completed!'
	echo 'Run `sudo make prod/docker/start`'
	echo ''
	echo '==========================='

prod/docker/start:
	docker compose -f ./compose.production.yml start

prod/docker/stop:
	docker compose -f ./compose.production.yml stop

prod/docker/down:
	docker compose -f ./compose.production.yml down --volumes
