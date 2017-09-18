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
