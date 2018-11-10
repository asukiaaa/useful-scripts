#/bin/bash
RUBY_VERSION=2.5.3
RAILS_VERSION=5.2.1

# docker-compose down
# docker rmi -f $(docker images -q)
# sudo rm -r *
# exit 1

echo "FROM ruby:$RUBY_VERSION
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /web
WORKDIR /web
ADD web/Gemfile /web/Gemfile
ADD web/Gemfile.lock /web/Gemfile.lock
RUN bundle install
ADD web /web" >> Dockerfile

mkdir web
touch web/Gemfile.lock
echo "source 'https://rubygems.org'
gem 'rails', '~> $RAILS_VERSION'" >> web/Gemfile

echo "version: '3'
services:
  db:
    image: mysql
    command: mysqld --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_USER: root
      MYSQL_ROOT_PASSWORD: password
    ports:
      - '3316:3306'
    volumes:
      - ./db/mysql/volumes:/var/lib/mysql

  web:
    build: .
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
    volumes:
      - ./web:/web
    ports:
      - '3000:3000'
    depends_on:
      - db
" >> docker-compose.yml

docker-compose run web rails new . -d mysql --force --skip-bundle
sudo chown -R $USER:$USER web db
sed -i -e 's/password:$/password: password/g' web/config/database.yml
sed -i -e 's/host: localhost$/host: db/g' web/config/database.yml
sudo rm -r web/.git
docker-compose build
docker-compose run web rake db:create
exit 1
docker-compose down

sudo rm -r db
docker rmi docker-test_web

docker-compose build
sudo chown -R $USER:$USER db
docker-compose 

# ref: https://stackoverflow.com/questions/30233105/docker-compose-up-for-only-certain-containers
# ref: https://github.com/nooptr/docker-rails-mysql
