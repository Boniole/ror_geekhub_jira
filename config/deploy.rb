lock "~> 3.17.1" # there should be your version, don`t change this!!!

set :repo_url, 'git@github.com:Boniole/ror_geekhub_jira.git'
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp # if you want to chose branch before each deploy
set :branch, ENV['BRANCH'] || 'main'


set :user, 'deployer'
set :puma_user, fetch(:user)
set :rvm_ruby_version, '3.1.2'
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key', 'config/puma.rb', 'config/.env')
set :linked_dirs,  fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'public/images',
                                                'storage')

set :config_example_suffix, '.example'
set :config_files, %w[config/database.yml config/.env]
set :nginx_use_ssl, false

namespace :deploy do
  before 'check:linked_files', 'set:master_key'
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:jungle:setup'
end

after 'deploy:finished', 'nginx:restart'
after 'deploy:finished', 'puma:restart'