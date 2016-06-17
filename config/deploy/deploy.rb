set :application, "cappwww"
application = "cappwww"
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

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.5'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

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
