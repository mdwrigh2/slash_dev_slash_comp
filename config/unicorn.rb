rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes ( rails_env == 'production' ? 16 : 4)

preload_app true

timeout 30

listen '/var/www/slash_dev_slash_comp/tmp/sockets/unicorn.sock'

pid '/var/www/slash_dev_slash_comp/tmp/pids/unicorn.pid'

stderr_path '/var/www/slash_dev_slash_comp/log/unicorn.stderr.log'
stdout_path '/var/www/slash_dev_slash_comp/log/unicorn.stdout.log'

before_fork do |server, worker|
  old_pid = RAILS_ROOT + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
