#!/bin/bash

if [ ! -e /etc/redis/redis.conf ]; then
    envsubst < "/etc/redis/redis.conf.tpl" > "/etc/redis/redis.conf"
    echo "Conf built."
fi

SNAPSHOT_VOLUME_DIR="/var/lib/redis/volume"

if [ -d "$SNAPSHOT_VOLUME_DIR" ]; then
    echo "Snapshots volume found, snapshots enabled."
else
    echo "Snapshots disabled (reason : no snapshot volume found)."
    sed -i -e 's/^\(save \d+ \d+\)/# \1/' -e 's/^\(dir .*\)/# \1/' /etc/redis/redis.conf
fi

exec "$@"
