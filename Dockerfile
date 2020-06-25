FROM emarcs/python:2

LABEL Marco Pompili "docker@mg.odd.red"

RUN apt-get -q -q update && \
    apt-get -q -y install libpcre3-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install uwsgi python-pcre django

RUN useradd django

RUN mkdir -p /srv/django/app && \
    chown django.django /srv/django/app

VOLUME ["/srv/django/app"]

ENV DJANGO_PROJECT_NAME django_site
ENV DJANGO_SETTINGS_MODULE django_site.settings
ENV UWSGI_HOST 0.0.0.0
ENV UWSGI_PORT 8000

COPY startup /etc/minit/
