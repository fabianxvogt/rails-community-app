ARG RUBY_VERSION=2.6.6

FROM ruby:${RUBY_VERSION}-alpine3.11

ARG NODE_VERSION=12.20.1-r0
ARG YARN_VERSION=1.19.2-r0

RUN apk update && apk add \
    build-base \
    ca-certificates \
    imagemagick \
    memcached \
    nodejs=$NODE_VERSION \
    postgresql-dev \
    tzdata \
    yarn=$YARN_VERSION

RUN mkdir /app
WORKDIR /app

ENV LANG=C.UTF-8 \
  GEM_HOME=/usr/local/bundle
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin

# That allows us to run rails, rake, rspec and other binstubbed commands
# without prefixing them with bundle exec.
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

# install bundler in specific version
ARG BUNDLER_VERSION=2.1.4

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v ${BUNDLER_VERSION} && \
    bundle install -j $(nproc) --retry 3 --without production

COPY package.json yarn.lock ./

RUN yarn install --non-interactive --check-files

ENV RAILS_LOG_TO_STDOUT=1

LABEL maintainer="Viktor Schmidt <viktorianer4life@gmail.com>"

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Check to see if server.pid already exists. If so, delete it.
RUN test -f tmp/pids/server.pid && rm -f tmp/pids/server.pid; true

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

CMD docker/db/validate-migrated.sh && rails s -b 0.0.0.0 -p 3000
