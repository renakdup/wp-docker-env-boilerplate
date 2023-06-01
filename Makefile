include .env
export

#UID = $(shell id -u)
#GUID = $(shell id -g)

##########################
# Docker
##########################
d:
	docker $(filter-out $@,$(MAKECMDGOALS))

d.up:
	docker-compose up -d

d.ps:
	docker ps

d.restart: d.down
	@$(MAKE) up

d.down:
	docker-compose down --remove-orphans

d.compose:
	docker-compose $(filter-out $@,$(MAKECMDGOALS))

d.build:
	docker-compose up --no-deps -d --build $(filter-out $@,$(MAKECMDGOALS))

d.build.all:
	docker-compose up -d --build

d.recreate:
	docker-compose up --no-deps -d --build $(filter-out $@,$(MAKECMDGOALS))

d.recreate.all:
	docker-compose up -d --force-recreate

d.test:
	docker run hello-world

##########################
# Nginx
##########################
nginx.connect:
	docker-compose exec nginx sh


##########################
# PHP
##########################
php.connect:
	docker-compose exec php bash

php.connect.root:
	docker-compose exec --user=root php bash


##########################
# MySQL
##########################
mysql.connect:
	docker-compose exec mysql bash
	#docker-compose exec mysql mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE}

mysql.client.connect:
	docker-compose exec mysql sh -c 'echo "Import db" && mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD}'

mysql.export:
	docker-compose exec mysql bash -c "mysqldump -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} > backup-`date +"\%Y.\%m.\%d_\%H-\%M-\%s"`.sql \
	&& chown -R ${UID}:${GUID} ./*"

mysql.import:
	docker-compose exec mysql mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < import_db.sql




##########################
# Composer
##########################
# Root directory
composer:
	cd ${PATH_TO_DOCKER} && docker-compose exec php composer $(filter-out $@,$(MAKECMDGOALS))

composer.install:
	docker-compose exec php composer install $(filter-out $@,$(MAKECMDGOALS))

composer.update:
	docker-compose exec php composer update $(filter-out $@,$(MAKECMDGOALS))


##########################
# Node
##########################
node.connect:
	docker run -it --rm --name=npm  -v "$(PWD)/:/usr/src/app" -w="/usr/src/app/" "node:${NODE_VER}" bash

node.install:
	docker run -it --rm --name=npm  -v "$(PWD)/:/usr/src/app" -w="/usr/src/app/" "node:${NODE_VER}" npm install

node.ci:
	docker run -it --rm --name=npm  -v "$(PWD)/:/usr/src/app" -w="/usr/src/app/" "node:${NODE_VER}" npm ci

node.update:
	docker run -it --rm --name=npm  -v "$(PWD)/:/usr/src/app" -w="/usr/src/app/" "node:${NODE_VER}" npm update

npm.webpack-start:
	docker run -it --rm --name=npm  -v "$(PWD)/:/usr/src/app" -w="/usr/src/app/" "node:${NODE_VER}" node npm start


##########################
# Linters
##########################
#lint.php:
#	docker-compose exec php sh -c 'composer run phpcs'
#
#lint.php.fix:
#	docker-compose exec php sh -c 'composer run phpcbf'


##########################
# Tests
##########################
#unit.run:
#	docker-compose exec php sh -c 'phpunit --do-not-cache-result'


##########################
# WP-CLI
##########################
wp:
	docker-compose exec php wp --allow-root $(filter-out $@,$(MAKECMDGOALS))

wp.core-clean.download:
	docker-compose exec php wp core download --skip-content --force --version=${WP_CORE_VERSION} --locale=${WP_CORE_LOCALE}

wp.core.download:
	docker-compose exec php wp core download --force --version=${WP_CORE_VERSION} --locale=${WP_CORE_LOCALE}

wp.core.install:
	docker-compose exec php wp core install --url=${SITE_DOMAIN} --title=${HH_INSTALL_ADMIN_TITLE} --admin_user=${INSTALL_ADMIN_LOGIN} --admin_email=${INSTALL_ADMIN_EMAIL} --admin_password=${INSTALL_ADMIN_PASSWORD}


##########################
# Commands helpers
##########################
# It is used for fixing access right errors for files on OS-side, has created on docker-side.
fix-access-right-for:
	sudo chown -R $(USER):$(shell  id -g -n) $(filter-out $@,$(MAKECMDGOALS))
