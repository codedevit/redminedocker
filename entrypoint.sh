#!/bin/bash
set -e
echo "### entrypoint iniciado ###"

# install GEMs Gemfile
/usr/local/bin/bundle install

# migrate tables
/usr/local/bin/bundle exec rake db:migrate RAILS_ENV="production"

# install redmine plugins
/usr/local/bin/bundle exec rake redmine:plugins:migrate RAILS_ENV=production

echo "### entrypoint finalizado ###"
exec "$@"
