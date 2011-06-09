set :application, "whatiswrongwith"
set :rails_env, "production"

ssh_options[:user] = "deployer"
ssh_options[:keys] = ["~/.ssh/id_dsa"]
ssh_options[:port] = 9090

set :main_server, "92.249.81.1"

role :app, main_server
role :web, main_server
role :db,  main_server, :primary => true

set :user, 'deployer'
set :group, 'deployer'
set :private_db_ip, "localhost"

set :branch, :master

set :server, :unicorn

set :use_sudo, false

set :deploy_to, "/var/data/www/apps/#{application}"

after "deploy", "deploy:migrate", "deploy:cleanup", "deploy:thin:restart"
after 'deploy:update_code', 'assets_precompile'