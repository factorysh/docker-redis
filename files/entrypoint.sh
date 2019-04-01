#!/bin/bash

if [ ! -e /etc/redis/redis.conf ]; then
    envsubst < "/etc/redis/redis.conf.tpl" > "/etc/redis/redis.conf"
fi

exec "$@"
