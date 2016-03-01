FROM django:1.9.2-python3

MAINTAINER Marco Pompili <marcs.pompili@gmail.com>

RUN apt-get update && apt-get -q -y install libpcre3-dev

RUN pip install uwsgi python-pcre

RUN useradd django

RUN mkdir -p /srv/django/app && \
    chown django.django /srv/django/app

VOLUME ["/srv/django/app"]

ENV DJANGO_PROJECT_NAME django_site
ENV DJANGO_SETTINGS_MODULE django_site.settings
ENV UWSGI_HOST 0.0.0.0
ENV UWSGI_PORT 8000

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["su", "django", "/usr/local/bin/entrypoint.sh"]
