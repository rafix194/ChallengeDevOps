FROM php:7.4.33-apache as builder

RUN apt-get update -qq \
  && apt-get install -y git libpq-dev \
  && apt-get clean autoclean \
  && apt-get autoremove -y 

COPY --from=composer:1.9.1 /usr/bin/composer /usr/bin/composer