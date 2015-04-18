FROM ruby:2.1.5
MAINTAINER Kévin Gomez <contact@kevingomez.fr>

# app dependencies
RUN apt-get update && apt-get install -y \
    libfontconfig1 \
    nodejs \
    redis-server \
    libpq-dev \
    supervisor

WORKDIR /srv
ADD Gemfile /srv/Gemfile
ADD Gemfile.lock /srv/Gemfile.lock
RUN bundle install --deployment
ADD . /srv

COPY config/docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN rake assets:precompile

VOLUME /srv/public/pdf

CMD ["/usr/bin/supervisord"]
