cd $APP_PATH

RAILS_ENV=production bin/delayed_job stop
RAILS_ENV=production bin/delayed_job start

RAILS_ENV=production clockworkd -c lib/clock.rb stop
RAILS_ENV=production clockworkd -c lib/clock.rb start --log

touch tmp/restart.txt