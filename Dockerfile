FROM bearstech/debian:stretch

RUN set -eux \
    &&  export http_proxy=${HTTP_PROXY} \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
                  gettext-base \
                  redis-server \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/* \
    &&  chown -R redis:redis /var/lib/redis \
    && rm /etc/redis/redis.conf \
    && chmod 777 /etc/redis

COPY files/entrypoint.sh /usr/local/bin/
COPY files/redis.conf.tpl /etc/redis/redis.conf.tpl

EXPOSE 6379

WORKDIR /var/lib/redis
USER redis
ENV MAXMEMORY=512mb
ENV MAXMEMORY_EVICTION=noeviction


ENTRYPOINT ["entrypoint.sh"]
CMD ["redis-server", "/etc/redis/redis.conf"]

# generated labels

ARG GIT_VERSION
ARG GIT_DATE
ARG BUILD_DATE

LABEL \
    com.bearstech.image.revision_date=${GIT_DATE} \
    org.opencontainers.image.authors=Bearstech \
    org.opencontainers.image.revision=${GIT_VERSION} \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.url=https://github.com/factorysh/docker-redis \
    org.opencontainers.image.source=https://github.com/factorysh/docker-redis/blob/${GIT_VERSION}/Dockerfile
