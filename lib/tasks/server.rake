class RailsRunner
  def self.pidfile
    'tmp/pids/server.pid'
  end
  
  def self.pid
    `cat #{pidfile}`
  end

  # Just check for existance of pid file
  def self.running?
    File.exists? pidfile
  end

  def self.start
    if running?
      puts "WARNING: rails server already running"
    else
      `rails s -d`
    end
  end

  def self.stop
    if running?
      `kill -INT #{pid}`
    else
      puts "WARNING: cannot stop rails server, it isn't started"
    end
  end
end


namespace :server do

  desc "Stop rails server"
  task :stop => :environment do
    RailsRunner.stop
  end

  desc "Start rails server"
  task :start => :environment do
    RailsRunner.start
  end

  desc "Restart rails server"
  task :restart => ["server:stop", "server:start"]

end
