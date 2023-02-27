server '164.90.165.89', user: "#{fetch(:user)}", roles: %w{app db web}, primary: true

set :application, 'mini_jira'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :environment, 'production'
set :rails_env,   'production'

set :nginx_server_name, '164.90.165.89'
set :puma_conf, "#{shared_path}/config/puma.rb"