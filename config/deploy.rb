require 'rvm/capistrano'
require 'bundler/capistrano'

server "popcorn.4eki.ru", :app, :web, :db, :primary => true
ssh_options[:port] = 11322

set :application, "popcornmenu"
set :rails_env, "production"
set :app_dir, "/home/#{application}"
set :deploy_to, "#{app_dir}"
set :user, "#{application}"
set :use_sudo, false

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :rvm_ruby_string, '2.1.1'
set :rvm_type, :user


set :repository, "git@bitbucket.org:query-string/#{application}.git"
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, false
set :deploy_via, :remote_cache


namespace :deploy do

  desc "Server restart."
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  desc "Symlink to public."
  task :symlink_public do
    run "mv #{release_path}/public #{release_path}/public_static"
    run "ln -s #{shared_path}/public #{release_path}/public"
    run "cp -r #{release_path}/public_static/* #{release_path}/public"
    run "rm -r #{release_path}/public_static"
  end
  desc "Compile asets"
  task :assets do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end
  desc "Symlink to upload."
  task :symlink_upload do
    #run "unlink #{release_path}/public/uploads"
    run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
    run "chmod 755 #{app_dir}"
  end

  desc "Database migrate."
  task :db_migrate do
    run "cd #{release_path}; bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  end

end


before 'deploy:symlink', 'deploy:assets'
after 'deploy:update_code', 'deploy:symlink_upload'
after 'deploy:symlink_upload', 'deploy:db_migrate'
after 'deploy:symlink_upload', 'deploy:update_crontab'
after :deploy, "deploy:cleanup"