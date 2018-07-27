
# This makefile is only used by docker-compose

REDIS_VERSION = ""

all: do_docker_compose

do_docker_compose:
	REDIS_VERSION=$(REDIS_VERSION) docker-compose down --remove-orphans
	REDIS_VERSION=$(REDIS_VERSION) docker-compose up -d --build server
	REDIS_VERSION=$(REDIS_VERSION) sleep 1
	REDIS_VERSION=$(REDIS_VERSION) docker-compose up --abort-on-container-exit --exit-code-from client client
	REDIS_VERSION=$(REDIS_VERSION) docker-compose down --remove-orphans
