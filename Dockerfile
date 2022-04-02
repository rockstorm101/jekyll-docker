ARG RUBY_VERSION=3.1
ARG ALPINE_VERSION=3.15
FROM ruby:${RUBY_VERSION}-alpine${ALPINE_VERSION}

# Install dependencies
RUN apk add --no-cache --virtual _builddeps \
  g++ \
  gcc \
  make

# Install bundler
RUN gem install --no-document bundler

# Install gems from the local Gemfile
COPY Gemfile* ./
RUN bundle install

# Delete build dependencies
RUN apk del _builddeps

# Create Jekyll working directory
ENV JEKYLL_DATA_DIR /srv/jekyll
RUN mkdir -p ${JEKYLL_DATA_DIR}
WORKDIR ${JEKYLL_DATA_DIR}

EXPOSE 4000

CMD ["jekyll", "--help"]
