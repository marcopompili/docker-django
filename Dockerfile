FROM python:3.8.5-buster

LABEL author Marco Pompili
LABEL email "docker@mg.odd.red"

COPY requirements.txt .

RUN pip install -r requirements.txt

RUN useradd django

RUN mkdir -p /srv/django/app && \
    chown django.django /srv/django/app

VOLUME ["/srv/django/app"]

ENV DJANGO_PROJECT_NAME django_site
ENV DJANGO_SETTINGS_MODULE django_site.settings
ENV UWSGI_HOST 0.0.0.0
ENV UWSGI_PORT 8000

COPY startup /usr/local/bin/startup

CMD ["/usr/local/bin/startup"]

