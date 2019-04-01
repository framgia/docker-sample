FROM ruby:2.6.2
ENV LANG C.UTF-8

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs \
                       mysql-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /webapp
WORKDIR /webapp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle install
