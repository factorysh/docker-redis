
include Makefile.lint
include Makefile.build_args

GOSS_VERSION := 0.3.5

all: pull build

pull:
	docker pull bearstech/debian:stretch

build: stretch

stretch:
	 docker build \
		$(DOCKER_BUILD_ARGS) \
			-t bearstech/redis:3.2 \
			.
	docker tag bearstech/redis:3.2 bearstech/redis:latest
	docker tag bearstech/redis:3.2 bearstech/redis:stretch

push:
	docker push bearstech/redis:3.2
	docker push bearstech/redis:latest

remove_image:
	docker rmi bearstech/redis:3.2
	docker rmi bearstech/redis:latest

tests_redis/bin/goss:
	mkdir -p tests_redis/bin
	curl -o tests_redis/bin/goss -L https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	chmod +x tests_redis/bin/goss

test3.2: tests_redis/bin/goss
	make -C tests_redis do_docker_compose

down:
	make -C tests_redis down

tests: test3.2
