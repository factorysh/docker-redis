
# This makefile is only used by docker-compose

all: do_docker_compose

do_docker_compose:
	docker-compose down --remove-orphans
	docker-compose up -d --build server
	sleep 1
	docker-compose up --abort-on-container-exit --exit-code-from client client
	docker-compose down --remove-orphans

down:
	docker-compose down --remove-orphans
