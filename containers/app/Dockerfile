FROM ruby:2.6.2
ENV LANG C.UTF-8

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get update -qq && \
    apt-get install -y build-essential \
                       mysql-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /webapp
WORKDIR /webapp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle install
