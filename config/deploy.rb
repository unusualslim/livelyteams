# config valid only for current version of Capistrano

set :application,	'livelyteams'
set :repo_url,		'https://github.com/unusualslim/livelyteams'
set :puma_threads,	[4,16]
set :puma_workers, 	0
#set :rbenv_ruby, 	'2.6.5'
set :rbenv_type, :user

set :rails_env,         'production'
set :migration_role, :app
set :puma_init_active_record, true

#set :passenger_environment_variables, { :path => '/usr/bin:$PATH' }
#set :passenger_restart_command, '/usr/bin/passenger-config restart-app'
#append :rbenv_map_bins, %w{rake gem bundle ruby rails puma pumactl}

#append :linked_files, 'config/master.key'
#append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# append :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/home/dev/apps/livelyteams'

#set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :default_env, {
   PATH: '$HOME/.npm-packages/bin/:$PATH',
   NODE_ENVIRONMENT: 'production'
}

#set :default_env, {
#   PATH: '$HOME/.npm-packages/bin/:$PATH',
#   NODE_ENVIRONMENT: 'production'
#}

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# before "deploy:assets:precompile", "deploy:yarn_install"
namespace :deploy do    
  desc 'Symlinks config files for Nginx.'
  task :nginx_symlink do
    on roles(:app) do
      execute "rm -f /etc/nginx/sites-enabled/default"

      execute "sudo ln -nfs #{current_path}/config/nginx.rb /etc/nginx/sites-enabled/#{fetch(:domain)}"
      execute "sudo ln -nfs   /config/nginx.rb /etc/nginx/sites-available/#{fetch(:domain)}"
   end
end
end
# namespace :deploy do
#  desc 'Run rake yarn:install'
#  task :yarn_install do
 #   on roles(:web) do
#      within release_path do
#        execute("cd #{release_path} && yarn install")
#     end
#    end
#  end
#end  

# namespace :deploy do
#  namespace :check do
#    before :linked_files, :set_master_key do
##      on roles(:app), in: :sequence, wait: 10 do
#        unless test("[ -f #{shared_path}/config/master.key ]")
#          upload! 'config/master.key', "#{shared_path}/config/master.key"
#        end
#      end
#    end
#  end
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key', 'config/credentials.yml.enc',)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# append :linked_files, fetch(:linked_files).push("config/database.yml", "config/credentials.yml.enc", "config/master.key")

# append :linked_dirs, fetch(:linked_dirs).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
    before :linked_files, :set_database_yml do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! 'config/database.yml', "#{shared_path}/config/database.yml"
        end
      end
    end
    before :linked_files, :set_credentials_yml do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/credentials.yml.enc ]")
          upload! 'config/credentials.yml.enc', "#{shared_path}/config/credentials.yml.enc"
        end
      end
    end
  end
end

#end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end



#namespace :deploy do
#  desc 'Restart application'
#  task :restart do
#    on roles(:app) do
#      execute "#{fetch(:rbenv_prefix)} pumactl -P ~/app/current/tmp/pids/puma.pid phased-restart"
#    end
#  end
#end

#after 'deploy:publishing', 'deploy:restart'
