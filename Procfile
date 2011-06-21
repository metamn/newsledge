web: bundle exec thin start -p $PORT
worker: bundle exec rake resque:work QUEUE=*
log: tail -f -n 0 log/development.log
autotest: autotest
