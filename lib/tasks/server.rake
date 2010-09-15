class RailsRunner
  def self.pid
    '/tmp/pids/server.pid'
  end

  # Just check for existance of pid file
  def self.running?
    File.exists? pid
  end

  def self.start
    unless running?
      `rails s -d`
    end
  end

  def self.stop
    if running?
      `kill -INT $(cat tmp/pids/server.pid)`
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
