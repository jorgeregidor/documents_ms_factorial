FROM ruby:2.6.3-alpine
LABEL maintainer="Jorge Regidor jorgeregidor@gmail.com"

ENV BUILD_PACKAGES bash curl-dev build-base libxml2-dev \ 
                        libxslt-dev poppler-utils \ 
                        poppler-data nano git

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN gem install bundler --no-document

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle config build.nokogiri

ARG MY_ENV_NAME
ENV MYENV=${MY_ENV_NAME}

# WORKDIR
RUN mkdir -p /usr/local/app/tmp/pids
WORKDIR /usr/local/app/

# RUBY STUFF
COPY . /usr/local/app
RUN bundle package
RUN bundle install --local

ADD . /usr/local/app