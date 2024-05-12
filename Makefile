# Makefile - должен находиться в одной папке с docker-compose.yml файлом
# make up, make down - запускает нижеследующие команды:
#---------------------------------------------------------------------------
#  При добавлении команд в phpstorm 2024 в Makefile - выбивает из программы и выдает глобальную ошибки и не сохраняет изменения
#  В phpstorm 2023 такой проблемы нет.

up:
	docker compose up -d
down:
	docker compose down
stop:
	docker compose stop
down-v:
	docker compose down -v
777:
	sudo chmod 777 -R .
777-mysql:
	sudo chmod 777 -R ./_docker/mysql_data
git-add-all:
	git add *

# social_app - container name, app - service, node - service,
social-app:
	docker exec -it social_app bash
npm-install:
	docker compose exec node npm install
composer-install:
	docker compose exec app composer install
npm-build:
	docker compose exec node npm run build
npm-dev:
	docker compose exec node npm run dev
tinker:
	docker compose exec app php artisan tinker

# if we change - "all - 1", we get - model, migration, factory, seeder, requests, policy, resource-controller
php-v:
	docker conpose exec app php -v
key:
	docker compose exec app php artisan key:generate
migrate:
	docker compose exec app php artisan migrate
rollback:
	docker compose exec app php artisan migrate:rollback
model:
	docker compose exec app php artisan make:model
resource:
	docker compose exec app php artisan make:resource
controller:
	docker compose exec app php artisan make:controller
request:
	docker compose exec app php artisan make:request

build:
	docker compose build --no-cache --force-rm
composer-update:
	docker exec app bash -c "composer update"
data:
	docker exec app bash -c "php artisan migrate"
	docker exec app bash -c "php artisan db:seed"

# make setup - запускает все нижележащие команды makefile
install:
	@make model
	@make request
	@make resource
	@make controller
setup:
	@make build
	@make up
	@make composer-update
