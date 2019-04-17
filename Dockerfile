FROM bearstech/debian:stretch

RUN set -eux \
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
VOLUME /var/lib/redis
USER redis
ENV MAXMEMORY=512mb
ENV MAXMEMORY_EVICTION=noeviction
ARG GIT_VERSION
LABEL com.bearstech.source.redis=https://github.com/factorysh/docker-redis/commit/${GIT_VERSION}

ARG GIT_DATE
LABEL com.bearstech.date.redis=${GIT_DATE}

ENTRYPOINT ["entrypoint.sh"]
CMD ["redis-server", "/etc/redis/redis.conf"]
