#!/bin/bash

if [ ! -e /etc/redis/redis.conf ]; then
    envsubst < "/etc/redis/redis.conf.tpl" > "/etc/redis/redis.conf"
    echo "Conf built."
fi

exec "$@"
