require 'bundler/capistrano'

set :application, "cappwww"
set :repository,  "git@swifthorse.trueinteraction.com:#{application}"

set :deploy_to, "/var/www/cappwww"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ssh_options[:keys] = ['~/.ssh/client_deploy/deploy_capp-usa_org.id_rsa']
set :scm_username, 'git'
set :user, 'deploy'

role :web, "capp-usa.org"                          # Your HTTP server, Apache/etc
role :app, "capp-usa.org"                          # This may be the same as your `Web` server
role :db,  "capp-usa.org", :primary => true # This is where Rails migrations will run

set :keep_releases, 10
set :use_sudo, false

set :rails_env, 'production'

require "capistrano-rbenv"
set :rbenv_ruby_version, "2.1.5"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

load 'config/deploy/global'
