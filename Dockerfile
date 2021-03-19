ARG RUBY_VERSION=2.6.6

FROM ruby:${RUBY_VERSION}-alpine3.11

LABEL maintainer="Viktor Schmidt <viktorianer4life@gmail.com>"

# install bundler in specific version
ARG BUNDLER_VERSION=2.1.4
# install node in specific version
ARG NODE_VERSION=12.21
# install yarn in specific version
ARG YARN_VERSION=1.19
# install postgresql in specific version
ARG POSTGRES_VERSION=12.6

RUN apk update && apk add \
    build-base \
    ca-certificates \
    imagemagick \
    memcached \
    less \
    nodejs=~$NODE_VERSION \
    postgresql-dev=~$POSTGRES_VERSION \
    tzdata \
    yarn=~$YARN_VERSION

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:${BUNDLER_VERSION} && \
    bundle install -j $(nproc) --retry 3 --without production

RUN yarn config set "strict-ssl" false
COPY package.json yarn.lock ./
RUN yarn install --non-interactive --check-files

ENV RAILS_LOG_TO_STDOUT=1

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# Check to see if server.pid already exists. If so, delete it.
CMD test -f tmp/pids/server.pid && rm -f tmp/pids/server.pid; true && \
    rails s -b 0.0.0.0 -p 3000
