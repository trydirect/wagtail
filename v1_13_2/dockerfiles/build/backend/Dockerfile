FROM python:3.6

MAINTAINER Optimum "info@optimum-web.com"

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV LANG en_US.UTF-8
ENV PYTHONIOENCODING utf_8

RUN apt-get update  && apt-get autoremove -y && apt-get install -y locales \
    supervisor uwsgi uwsgi-src uuid-dev libcap-dev net-tools lsof
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# compile uwsgi plugin for python3.6
RUN PYTHON=python3.6 uwsgi --build-plugin "/usr/src/uwsgi/plugins/python python36"
RUN mv python36_plugin.so /usr/lib/uwsgi/plugins/python36_plugin.so

COPY locale.gen /etc/locale.gen
COPY default.locale /etc/default/locale
COPY configs/supervisord/wagtail.conf /etc/supervisor/conf.d/wagtail.conf
COPY wsgi.ini /etc/wagtail-wsgi.ini
COPY wagtail.conf /etc/supervisor/conf.d/wagtail.conf
COPY requirements.txt /etc/wagtail-requirements.txt

RUN locale -a

RUN pip install -r /etc/wagtail-requirements.txt
RUN wagtail start app
RUN groupadd -r -g 2000 wagtail; useradd -r -u 2000 -g 2000 -m -c "app account" -d /home/wagtail -s /bin/bash wagtail

WORKDIR /app
EXPOSE 8000
