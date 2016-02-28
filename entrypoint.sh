#!/bin/sh

uwsgi --chdir=/srv/django/app \
    --module=$DJANGO_PROJECT_NAME.wsgi:application \
    --master \
    --vhost \
    --pidfile=/tmp/$DJANGO_PROJECT_NAME.pid \
    --socket=$UWSGI_HOST:$UWSGI_PORT \
    --processes=5 \
    --uid=1000 --gid=1000 \
    --post-buffering \
    --harakiri=20 \
    --max-requests=5000 \
    --enable-threads \
    --vacuum
