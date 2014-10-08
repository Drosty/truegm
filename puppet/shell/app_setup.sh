#!/bin/bash

source /usr/local/share/chruby/chruby.sh
chruby `echo /home/vagrant/truegm/.ruby-version`

APP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
cd "$APP_HOME" || exit 1

bundle install && \
  bundle exec rake db:schema:load &&
  bundle exec rake db:seed
