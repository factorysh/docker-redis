all: jessie stretch latest 

jessie:
	docker build -t bearstech/redis:$@ -f Dockerfile.$@ .

stretch:
	docker build -t bearstech/redis:$@ -f Dockerfile.$@ .

latest: stretch
	docker tag bearstech/redis:$< bearstech/redis:$@

pull:
	docker pull bearstech/debian:stretch
	docker pull bearstech/debian:jessie

push:
	docker push bearstech/redis:jessie
	docker push bearstech/redis:stretch
	docker push bearstech/redis:latest
