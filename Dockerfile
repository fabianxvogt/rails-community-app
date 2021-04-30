ARG RUBY_VERSION=2.6.6

# Use an official Ruby runtime as a parent image
FROM ruby:${RUBY_VERSION}-alpine3.11

LABEL maintainer="Viktor Schmidt <viktorianer4life@gmail.com>"

# install bundler in specific version
ARG BUNDLER_VERSION=2.2
# install node in specific version
ARG NODE_VERSION=12.22
# install yarn in specific version
ARG YARN_VERSION=1.19
# install postgresql in specific version
ARG POSTGRES_VERSION=12.6

RUN apk add --update --virtual \
    build-base \
    ca-certificates \
    file \
    gcc \
    g++\
    git \
    imagemagick \
    less \
    libc-dev \
    libffi-dev \
    libsass-dev\
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    memcached \
    nodejs=~$NODE_VERSION \
    postgresql-client \
    postgresql-dev=~$POSTGRES_VERSION \
    readline \
    readline-dev \
    tzdata \
    yarn=~$YARN_VERSION && \
    rm -rf /var/cache/apk/*

# Set the working directory
RUN mkdir -p /app
WORKDIR /app

# COPY Gemfile Gemfile.lock ./
RUN gem install bundler:${BUNDLER_VERSION} && \
    bundle config force_ruby_platform true
# bundle install -j $(nproc) --retry 3 --without production

# COPY package.json yarn.lock ./
RUN yarn config set "strict-ssl" false
# yarn install --non-interactive --check-files

ENV RAILS_LOG_TO_STDOUT=1

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# Check to see if server.pid already exists. If so, delete it.
CMD test -f tmp/pids/server.pid && rm -f tmp/pids/server.pid; true && \
    rails s -b 0.0.0.0 -p 3000
