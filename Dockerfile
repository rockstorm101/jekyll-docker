FROM ruby:3.1.3-alpine3.17

ENV SETUPDIR=/setup
WORKDIR ${SETUPDIR}
COPY . .

# Install build dependencies
RUN set -eux; \
    apk add --no-cache --virtual build-deps \
        build-base \
        zlib-dev \
    ;

# Install Bundler
RUN set -eux; gem install bundler

# Install gems from `Gemfile` via Bundler
RUN set -eux; bundler install

# Remove build dependencies
RUN set -eux; apk del build-deps

# Clean up
WORKDIR /srv/jekyll
RUN set -eux; \
    rm -r \
        ${SETUPDIR} \
        ${GEM_HOME}/cache \
        /root/.bundle/cache \
    ;

ENTRYPOINT ["bundler", "exec", "jekyll"]
CMD ["--version"]
