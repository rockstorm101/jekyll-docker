FROM ruby:3.1-alpine3.15

# Install dependencies
RUN set -eux; \
  apk add --no-cache --virtual _builddeps \
    g++ \
    gcc \
	make \
  ;

# Install bundler
RUN gem install --no-document bundler

# Install gems from the local Gemfile and/or Gemfile.lock
COPY Gemfile* ./
RUN bundle install

# Delete build dependencies
RUN apk del _builddeps

# Create Jekyll working directory
ENV JEKYLL_DATA_DIR /srv/jekyll
RUN mkdir -p ${JEKYLL_DATA_DIR}
WORKDIR ${JEKYLL_DATA_DIR}

EXPOSE 4000

ENTRYPOINT ["bundle", "exec", "jekyll"]
CMD ["--help"]
