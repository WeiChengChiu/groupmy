# config valid for current version of Capistrano
lock "~> 3.11.0"

`ssh-add` # 注意這是鍵盤左上角的「 `」不是單引號「 '」
set :repo_url, 'https://github.com/WeiChengChiu/groupmy.git'
set :deploy_to, '/home/apps/groupmy'
set :keep_releases, 5

set :rbenv_type, :system
set :rbenv_ruby, "2.2.6"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all
set :default_stage, "production"

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'unicorn:reload'
