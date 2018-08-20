path = "/home/apps/groupmy/shared"
listen "#{path}/tmp/unicorn.sock"
worker_processes 2

pid "#{path}/tmp/pids/unicorn.pid"
stderr_path "#{path}/log/unicorn.log"
stdout_path "#{path}/log/unicorn.log"
