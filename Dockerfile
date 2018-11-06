FROM ubuntu:bionic

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Ruby build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            ca-certificates \
            gcc \
            libffi-dev \
            libgdbm-dev \
            libgmp-dev \
            libncurses5-dev \
            libreadline-dev \
            libssl-dev \
            libyaml-dev \
            make \
            zlib1g-dev \
            unzip \
            && \
    rm -rf /var/lib/apt/lists/*

# skip installing gem documentation
RUN mkdir -p /usr/local/etc && \
    { \
      echo 'install: --no-document'; \
      echo 'update: --no-document'; \
    } >> /usr/local/etc/gemrc

ARG RUBY_VERSION=2.5.1
ENV RUBY_VERSION=$RUBY_VERSION
ENV RUBYGEMS_VERSION=2.7.8
ENV BUNDLER_VERSION=1.17.1

ADD ruby_build_dep.txt /tmp
ADD install_ruby.sh /tmp
RUN /tmp/install_ruby.sh