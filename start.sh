#!/bin/bash

DEPHOME=/home/deploy
WEBDIR=/var/www
REPO=capp-usa

RAILS_ENV=$1

if [ -z "$RAILS_ENV" ]; then
	RAILS_ENV=production
fi

source /usr/local/rvm/scripts/rvm
rvm use `cat .ruby-version`@`cat .ruby-gemset` >> /dev/null

echo "** Bundle install **"
bundle install

echo "** Database migrations **"
bundle exec rake db:migrate RAILS_ENV=$RAILS_ENV
bundle exec rake db:seed RAILS_ENV=$RAILS_ENV

echo "** Starting solr **"
bundle exec rake sunspot:solr:start RAILS_ENV=$RAILS_ENV

echo "** Compiling assets **"
bundle exec rake assets:clean
bundle exec rake assets:precompile

echo "** Starting Unicorn **"
bundle exec unicorn_rails -c $WEBDIR/$REPO/config/unicorn-capp.rb -E $RAILS_ENV -D

echo "** Starting Delayed Job **"
bundle exec rake jobs:work RAILS_ENV=$RAILS_ENV
