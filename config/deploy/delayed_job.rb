
require 'delayed/recipes'

after 'deploy:stop', 'delayed_job:stop'
after 'deploy:start', 'delayed_job:start'
after 'deploy:restart', 'delayed_job:restart'
before 'deploy:create_symlink', 'delayed_job:stop'
