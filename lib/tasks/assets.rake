namespace :assets do

  desc "Compile all"
  task :compile => ["assets:compile:all"] do
    puts "compile all..."
    `compass compile`
  end
  
  namespace :compile do
    desc "Compile all"
    task :all => ["assets:compile:compass"]
    
    desc "Compile Compass stylesheets"
    task :compass => :environment do
      puts "compass compile"
      `compass compile`
    end
    
  end
  
  desc "Compile sass and jammit assets for production"
  task :package => "assets:compile" do
    # TODO: replace hardcoded with SITE_URL (from production)
    puts 'jammit -u "http://image-a-day.com"...'
    `jammit -u "http://image-a-day.com"`
  end
end
