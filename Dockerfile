FROM bearstech/debian:stretch

ARG DEBIAN_DISTRO

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
                  redis-server \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/* \
    &&  chown -R redis:redis /var/lib/redis

COPY files/redis.conf /etc/redis/redis.conf

EXPOSE 6379

WORKDIR /var/lib/redis
USER redis

CMD ["redis-server", "/etc/redis/redis.conf"]
