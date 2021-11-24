FROM php:7.0-fpm-alpine

RUN mkdir /scripts

COPY *build.sh /scripts

RUN if [[ -f "/scripts/build.sh" ]]; then sh /scripts/build.sh ; fi
