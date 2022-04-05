
include Makefile.lint
include Makefile.build_args

GOSS_VERSION := 0.3.16

all: pull build

pull:
	docker pull bearstech/debian:stretch

build: stretch buster bullseye

stretch:
	 docker build \
		$(DOCKER_BUILD_ARGS) \
		--build-arg=DEBIAN_VERSION=stretch \
		-t bearstech/redis:3.2 \
		.
	docker tag bearstech/redis:3.2 bearstech/redis:stretch

buster:
	 docker build \
		$(DOCKER_BUILD_ARGS) \
		--build-arg=DEBIAN_VERSION=buster \
		-t bearstech/redis:5.0 \
		.
	docker tag bearstech/redis:5.0 bearstech/redis:buster

bullseye:
	 docker build \
		$(DOCKER_BUILD_ARGS) \
		--build-arg=DEBIAN_VERSION=bullseye \
		-t bearstech/redis:6.0 \
		.
	docker tag bearstech/redis:6.0 bearstech/redis:latest
	docker tag bearstech/redis:6.0 bearstech/redis:bullseye

push:
	docker push bearstech/redis:3.2
	docker push bearstech/redis:5.0
	docker push bearstech/redis:6.0
	docker push bearstech/redis:latest

remove_image:
	docker rmi bearstech/redis:3.2
	docker rmi bearstech/redis:5.0
	docker rmi bearstech/redis:6.0
	docker rmi bearstech/redis:latest

tests_redis/bin/goss:
	mkdir -p tests_redis/bin
	curl -o tests_redis/bin/goss -L https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	chmod +x tests_redis/bin/goss

test3.2: tests_redis/bin/goss
	make -C tests_redis do_docker_compose DEBIAN_VERSION=stretch REDIS_VERSION=3.2

test5.0: tests_redis/bin/goss
	make -C tests_redis do_docker_compose DEBIAN_VERSION=buster REDIS_VERSION=5.0

test6.0: tests_redis/bin/goss
	make -C tests_redis do_docker_compose DEBIAN_VERSION=bullseye REDIS_VERSION=6.0

down:
	make -C tests_redis down

tests: test3.2 test5.0 test6.0
