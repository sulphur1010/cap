kill -9 `cat tmp/pids/unicorn.pid`
kill `ps -ef | grep unicorn-capp.rb | grep -v grep | awk '{print $2}'`
kill `ps -ef | grep solr | grep -v grep | awk '{print $2}'`
kill `ps -ef | grep delayed_job | grep -v grep | awk '{print $2}'`
