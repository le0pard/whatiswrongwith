require "capistrano/ext/multistage"
require "bundler/capistrano"
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require File.expand_path('../../lib/capistrano_recipes/tasks/capistrano_database_yml.rb', __FILE__)
require File.expand_path('../../lib/capistrano_recipes/tasks/thin.rb', __FILE__)
require 'thinking_sphinx/deploy/capistrano'
#Dir['lib/capistrano_recipes/tasks/*.rb'].each { |task| require task }

set :stages, %w(production)
set :default_stage, "production"

set :scm, :git
set :scm_verbose, false
set :repository,  "git://github.com/le0pard/whatiswrongwith.git"

set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :keep_releases, 3

set :rvm_ruby_string, '1.9.2@whatiswrongwith_gems'

task :assets_precompile, :roles => :app, :except => { :no_release => true } do
  run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
end

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end