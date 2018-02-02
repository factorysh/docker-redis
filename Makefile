GOSS_VERSION := 0.3.5

all: jessie stretch

jessie:
	docker build -t bearstech/redis:2.8 -f Dockerfile.$@ .

stretch:
	docker build -t bearstech/redis:3.2 -f Dockerfile.$@ .
	docker tag bearstech/redis:3.2 bearstech/redis:latest

pull:
	docker pull bearstech/debian:stretch
	docker pull bearstech/debian:jessie

push:
	docker push bearstech/redis:2.8
	docker push bearstech/redis:3.2
	docker push bearstech/redis:latest


tests/bin/goss:
	mkdir -p tests/bin
	curl -o tests/bin/goss -L https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	chmod +x tests/bin/goss

test: tests/bin/goss
	cd tests && docker-compose up -d server
	cd tests && docker-compose up client
	cd tests && docker-compose down
