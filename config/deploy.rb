set :application, "rails_template"
set :repository,  "git@github.com:vivrass/rails_template.git"

set :scm, :git
set :deploy_via, :remote_cache

role :web, "127.0.0.1"
role :app, "127.0.0.1"
role :db,  "127.0.0.1", :primary => true

set :user, 'rails_template'
set :deploy_to, "/data/rails_template"
ssh_options[:forward_agent] = true

$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user

default_run_options[:pty] = true

after "deploy:update_code" do
  run "cd #{release_path} && bundle install --without test:development"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, "tmp", "restart.txt")}"
  end
end
