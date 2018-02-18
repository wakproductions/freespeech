FROM ruby:2.4.2
# Node is needed for certain Javascript add-ons like Uglifier of Coffee-rails
# Netcat needed for wait-for-database.sh script
RUN apt-get update && apt-get install -y \
  nodejs \
  npm \
  netcat
RUN npm install -y yarn

WORKDIR /app
ADD . /app

RUN gem install bundler -v 1.16.1
RUN bundle install

