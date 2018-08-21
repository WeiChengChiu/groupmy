path = "/home/apps/groupmy/shared"
listen "#{path}/tmp/unicorn.sock"
worker_processes 2

pid "#{path}/tmp/pids/unicorn.pid"
stderr_path "#{path}/log/unicorn.log"
stdout_path "#{path}/log/unicorn.log"

preload_app true
check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

    # 加上 old_pid 相關的程式碼，用以讓新舊master worker是以逐漸交替的方式交換
    old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end
end

after_fork do |server, worker|
  defined?(ActiceRecord::Base) and
    ActiveRecord::Base.establish_connection
end
