
load 'config/deploy/unicorn'
load 'config/deploy/release'
load 'config/deploy/delayed_job'
require 'bundler/capistrano'
require 'delayed/recipes'

namespace :deploy do
	
	task :test_path, :roles => :app do
		run "env | grep -i path"
	end

	desc "deploy application"
	task :start, :roles => :app do
	end

	desc "initialize application for deployment"
	task :setup, :roles => :app do
		run "cd #{deploy_to} && mkdir -p releases shared shared/pids"
	end

	desc "clone repository"
	task :setup_code, :roles => :app do
		run "cd #{deploy_to} && git clone #{repository} cache"
	end

	desc "update VERSION"
	task :update_version, :roles => :app do
		run "cd #{deploy_to}/cache && git describe --abbrev=0 HEAD > ../current/VERSION && cat ../current/VERSION"
	end

	desc "dummy update_code task"
	task :update_code, :roles => :app do
	end

	desc "update codebase"
	task :pull_repo, :roles => :app do
		run "cd #{deploy_to}/cache && git pull"
	end

	desc "symlink stylesheets-less"
	task :symlink_stylesheets_less, :roles => :app do
		run "cd #{release_path}/public && ln -s #{deploy_to}/shared/stylesheets-less/ stylesheets-less"
	end

	desc "make release directory"
	task :make_release_dir, :roles => :app do
		run "mkdir #{release_path}"
	end

	desc "copy code into release folder"
	task :copy_code_to_release, :roles => :app do
		run "cd #{deploy_to}/cache && cp -pR * #{release_path}/"
	end

	desc "bundle install gems"
	task :bundle_install, :roles => :app do
		run "cd #{release_path} && sudo bundle install"
	end

	desc "run rake:db:migrate"
	task :migrate_db, :roles => :app do
		run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:migrate"
	end

	desc "run rake roles:default_permissions"
	desc "restart server"
	task :restart, :roles => :app do
		#run "cd #{deploy_to}/current && mongrel_rails cluster::restart"
		unicorn.restart
	end

	desc "make tmp directories"
	task :make_tmp_dirs, :roles => :app do
		run "cd #{deploy_to}/current && mkdir -p tmp/pids tmp/sockets"
	end

	desc "symlink pids directory"
	task :symlink_pids_dir, :roles => :app do
		run "cd #{release_path}/tmp && ln -s #{deploy_to}/shared/pids"
	end

	desc "symlink system directory"
	task :symlink_system_dir, :roles => :app do
		run "cd #{release_path}/public && ln -s #{deploy_to}/shared/system"
	end

	desc "create tmp/cache directory"
	task :create_cache_dir, :roles => :app do
		run "cd #{release_path}/tmp && mkdir -p cache"
	end

	desc "symlink database.yml"
	task :symlink_database_yml, :roles => :app do
		run "cd #{release_path}/config && ln -s _database.yml database.yml"
	end

	desc "symlink initializers"
	task :symlink_initializers, :roles => :app do
		run "cd #{release_path}/config/initializers && ln -s #{deploy_to}/shared/config/initializers/site_keys.rb"
	end

	desc "compile assets"
	task :compile_assets, :roles => :app do
		run "cd #{release_path} && bundle exec rake assets:precompile"
	end

	desc "deploy the precompiled assets"
	task :deploy_assets, :except => { :no_release => true } do
		run_locally("RAILS_ENV=development rake assets:clean && RAILS_ENV=development rake assets:precompile")
		run_locally("tar -czvf public/assets.tgz public/assets")
		top.upload("public/assets.tgz", "#{release_path}/public/", { :via => :scp, :recursive => true })
		run "cd #{release_path} && tar -zxvf public/assets.tgz 1> /dev/null"
	end

	task :finalize_update, :roles => :app do
	end
end

after 'deploy:setup', 'deploy:setup_code'
after 'deploy:pull_repo', 'deploy:copy_code_to_release'
before 'deploy:update_code', 'deploy:pull_repo'
after 'deploy:update_code', 'deploy:finalize_update'
#before 'deploy:restart', 'deploy:compile_assets'
before 'deploy:restart', 'deploy:deploy_assets'
before 'deploy:copy_code_to_release', 'deploy:make_release_dir'
before 'deploy:restart', 'deploy:migrate_db'
before 'deploy:symlink_database_yml', 'deploy:symlink_initializers'
after 'deploy:create_symlink', 'deploy:update_version'

after 'deploy:create_symlink', 'deploy:make_tmp_dirs'
after 'deploy:make_tmp_dirs', 'deploy:create_cache_dir'
before 'deploy:restart', 'deploy:symlink_system_dir'

after 'deploy', 'deploy:cleanup'
