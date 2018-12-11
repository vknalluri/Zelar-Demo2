# config valid for current version and patch releases of Capistrano
require 'httparty'    
require 'increment_semver'

lock "~> 3.11.0"

set :application, "travel-agency"
set :repo_url,  "git@github.com:saplingapp/demo-sm.git"
set :repo_tree, "/travel-agency"
set :rvm_ruby_version, '2.5.1'
set :user, "sandeep"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true
set :ssh_options, {
  keys: [File.join(ENV["HOME"], ".ssh", "id_rsa")]
}
# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :use_sudo, true
set :rvm_type, :user
set :rvm_map_bins, %w{gem rake ruby rails bundle}
#set :linked_dirs, %w{node_modules}

namespace :deploy do 
  task :npm_install do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        #execute :npm, "install --production --silent" 
        #execute :ng, "build --prod"
      end
    end
  end
  
  task :record_revision do
    desc 'Record deployed revision'  
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        # execute :cat, "#{current_path}/REVISION"
        @server_ip = capture("curl ifconfig.me")        
        @request_url = "http://#{@server_ip}:3000/api/v1/versions"
        @current_version_number = HTTParty.get( @request_url+"?app_name=frontend", :headers => { 'Content-Type' => 'application/json' })  
        if @current_version_number.parsed_response.empty?
          @new_version_number = "1.0.0"
        else
          @version_number = @current_version_number.parsed_response
          @new_version_number = increment_semver(@version_number, 'minor')               
        end
        @result = HTTParty.post(@request_url, :body => { 
          :version_number => @new_version_number, 
          :app_name => "frontend"
        }.to_json, :headers => { 'Content-Type' => 'application/json' } )   
        if @result.parsed_response["error"].nil?
          p "Revision recorded successfully."
        else 
          p "#{@result.parsed_response["error"]}"
        end
      end      
    end
  end
  after :publishing, :record_revision
end
