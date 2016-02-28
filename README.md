# docker-django

Docker image for
[Django](https://www.djangoproject.com/) production environments.

## Description

This is a middle-ware image, should not be used as a final
image for a Django production environment. You should write
your own derivative image with the needed dependencies for your
own project.

The container will launch a
[uWSGI](https://uwsgi-docs.readthedocs.org/en/latest/) instance
referring to the volume where the Django app is mounted, the path is:

```shell
/webapps/gunicorn/django
```

The uWSGI process is listening on port 8000, but you can use
these environment variables to configure it, here the variables
with their default values:

```shell
$UWSGI_HOST 0.0.0.0
$UWSGI_PORT 8000
```

To setup the uWSGI module you have another two environment
variables at your disposal:

```shell
$DJANGO_PROJECT_NAME django_site
$DJANGO_WSGI_MODULE django_site.wsgi
```

uWSGI should be proxified through Nginx, docker-compose helps a lot
for configuring multiple containers linked each other.

## Using Docker Compose

Docker Compose can simplify the configuration ed installation
when using multiple containers.

Here is an example:

```yml
version: '2'

services:
  django_site_uwsgi:
    image: emarcs/django:latest
    volumes:
      - ./data:/srv/django/app/
  django_site_nginx:
    image: emarcs/nginx-uwsgi
    ports:
      - 8081:80
    links:
      - django_site_uwsgi:uwsgi_srv
    volumes:
      - ./data/static/:/srv/django/static/
      - ./data/media/:/srv/django/media/
```

In the above example the nginx_srv container is linked to the
uwsgi container. The nginx_srv container will serve the static
files and call the uWSGI container for server requests.

The nginx container is using [another docker image](https://github.com/marcopompili/docker-nginx-uwsgi) that
I specifically built for serving uWSGI through an Nginx proxy.

## Notes

*   [Docker-Nginx-uWSGI](https://github.com/marcopompili/docker-nginx-uwsgi):
My Nginx image for serving uWSGI.

*   [Django Framework](https://www.djangoproject.com/):
The Django official site.

*   [uWSGI documentation](https://uwsgi-docs.readthedocs.org/en/latest/):
The docs for configuring uWSGI.
