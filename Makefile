
d.ps:
	docker ps

d.up:
	docker-compose up -d

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
	docker exec -it $(filter-out $@,$(MAKECMDGOALS)) bash
