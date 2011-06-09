unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

Capistrano::Configuration.instance.load do

  namespace :deploy do

    namespace :thin do

      desc <<-DESC
        Creates the thin.conf.rb configuration file in shared path.
      DESC
      task :setup, :except => { :no_release => true } do
        run "mkdir -p #{shared_path}/db" 
        run "mkdir -p #{shared_path}/config" 
        run "cd #{current_path}; bundle exec thin config -C #{shared_path}/config/thin.yml -c #{current_path} -e #{fetch(:rails_env, "production")} -d -s 6 -u #{fetch(:user, "deployer")} -g #{fetch(:group, "deployer")} -l #{shared_path}/log/thin.log -P #{shared_path}/tmp/pids/thin.pid -S #{shared_path}/tmp/sockets/thin.sock"
      end
      
      desc <<-DESC
        Restart thin
      DESC
      task :restart, :except => { :no_release => true }, :on_error => :continue do
        run "cd #{release_path}; bundle exec thin restart -C #{shared_path}/config/thin.yml" 
      end
      
      desc <<-DESC
        Start thin
      DESC
      task :start, :except => { :no_release => true } do
        run "cd #{release_path}; bundle exec thin start -C #{shared_path}/config/thin.yml"
      end
      
      desc <<-DESC
        Stop thin
      DESC
      task :stop, :except => { :no_release => true }, :on_error => :continue do
        run "cd #{release_path}; bundle exec thin stop -C #{shared_path}/config/thin.yml"
      end

    end

    after "deploy:setup",           "deploy:thin:setup"

  end

end