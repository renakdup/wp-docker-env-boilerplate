include .env
export

UID = $(shell id -u)
GUID = $(shell id -g)

# Build
env.create:
	@echo $(shell docker/sh/create.env.sh)


# Docker
d.test:
	docker run hello-world

d.ps:
	docker ps

d.up:
	docker-compose up -d

d.restart: d.down
	@$(MAKE) up

d.down:
	docker-compose down

d.build-image:
	docker-compose up -d --no-deps --build $(filter-out $@,$(MAKECMDGOALS))

d.build-all-images:
	docker-compose up -d --no-deps --build

d.recreate-container:
	docker-compose up -d --force-recreate $(filter-out $@,$(MAKECMDGOALS))

d.recreate-all-containers:
	docker-compose up -d --force-recreate

d.bash:
	docker-compose exec $(filter-out $@,$(MAKECMDGOALS)) bash


# MySQL
mysql.export:
	docker-compose exec mysql bash -c "mysqldump -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} > backup-`date +"\%Y.\%m.\%d_\%H-\%M-\%s"`.sql \
	&& chown -R ${UID}:${GUID} ./*"

mysql.import:
	docker-compose exec mysql mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < import_db.sql

mysql.connect:
	docker-compose exec mysql mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE}


# Composer
c:
	docker-compose exec php composer $(filter-out $@,$(MAKECMDGOALS))

c.install:
	docker-compose exec php composer install $(filter-out $@,$(MAKECMDGOALS))

c.install-production:
	docker-compose exec php composer install --no-dev

c.update:
	docker-compose exec php composer update $(filter-out $@,$(MAKECMDGOALS))

c.update-production:
	docker-compose exec php composer update --no-dev


# Front
npm.install:
	docker-compose run --rm node npm install

npm.ci:
	docker-compose run --rm node npm ci

npm.update:
	docker-compose run --rm node npm update

npm.webpack-start:
	docker-compose run --rm node npm start


# WP-CLI
wp:
	docker-compose exec php wp --allow-root $(filter-out $@,$(MAKECMDGOALS))

wp.activate-theme:
	@$(MAKE) wp theme activate ${WP_THEME}


# It is used for fixing access right errors for files on OS-side, has created on docker-side.
fix-access-right-for:
	sudo chown -R $(USER):$(shell  id -g -n) $(filter-out $@,$(MAKECMDGOALS))
