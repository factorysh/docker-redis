
# This makefile is only used by docker-compose

DEBIAN_VERSION?=buster

export DEBIAN_VERSION

all: do_docker_compose

do_docker_compose:
	echo DEBIAN_VERSION=$(DEBIAN_VERSION)
	docker-compose down --remove-orphans
	docker-compose up -d --build server
	sleep 1
	docker-compose up --abort-on-container-exit --exit-code-from client client
	docker-compose down --remove-orphans

down:
	docker-compose down --remove-orphans
