#!/bin/sh

VERSION="1.13.5"
#docker-compose build -t optimum/cms:wagtail-$VERSION-s $1
docker-compose build
docker tag build_web:latest optimum/cms:wagtail-$VERSION-s
docker push optimum/cms:wagtail-$VERSION-s
