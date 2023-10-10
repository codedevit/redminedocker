#!/bin/bash
set -e
echo "### entrypoint iniciado ###"

# install GEMs Gemfile
/usr/local/bin/bundle install

/usr/local/bin/gem install 'debug'

/usr/local/bin/gem install 'ruby-debug-ide'

# migrate tables
/usr/local/bin/bundle exec rake db:migrate RAILS_ENV="production"

# install redmine plugins
/usr/local/bin/bundle exec rake redmine:plugins:migrate RAILS_ENV=production

echo "### entrypoint finalizado ###"
exec "$@"
