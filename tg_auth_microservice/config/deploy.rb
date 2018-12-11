# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
set :default_shell, "/bin/bash -l"
set :rvm_ruby_version, '2.5.1'
set :default_stage, "production"
set :application, "tg_auth_microservice"
set :user, "sandeep"
set :repo_url,  "git@github.com:saplingapp/demo-sm.git"
set :repo_tree, "/tg_auth_microservice"
set :use_sudo, true
set :rvm_type, :user
set :rvm_map_bins, %w{gem rake ruby rails bundle}
set :pty, true #if you don't do this you'll get a tty sudo error on EC2
set :ssh_options, {
  keys: [File.join(ENV["HOME"], ".ssh", "id_rsa")]
}
set :keep_releases, 4  # only keep 4 version to save space
set :copy_exclude, [".git",".gitignore","/app/config/database.yml"]
set :normalize_asset_timestamps, false

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "ln -nfs #{deploy_to}/shared/system #{release_path}/public/system"
      execute "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
      execute "ln -nfs #{deploy_to}/shared/config/master.key #{release_path}/config/master.key"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :publishing, :restart
end