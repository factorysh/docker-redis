GOSS_VERSION := 0.3.5

all: pull build

pull:
	docker pull bearstech/debian:stretch
	docker pull bearstech/debian:jessie

build: jessie stretch

jessie:
	docker build \
			-t bearstech/redis:2.8 \
			--build-arg DEBIAN_DISTRO=jessie \
			.

stretch:
	docker build \
			-t bearstech/redis:3.2 \
			--build-arg DEBIAN_DISTRO=stretch \
			.
	docker tag bearstech/redis:3.2 bearstech/redis:latest

push:
	docker push bearstech/redis:2.8
	docker push bearstech/redis:3.2
	docker push bearstech/redis:latest

tests/bin/goss:
	mkdir -p tests/bin
	curl -o tests/bin/goss -L https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	chmod +x tests/bin/goss


test2.8: tests/bin/goss
	make -C tests do_docker_compose REDIS_VERSION=2.8

test3.2: tests/bin/goss
	make -C tests do_docker_compose REDIS_VERSION=3.2

tests: test2.8 test3.2
