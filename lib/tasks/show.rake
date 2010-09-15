require 'columize'

namespace :show do

  desc "Show all info in all the database tables"
  task :all => :environment do
    
    Dir["app/models/**/*.rb"].each do |file|
      klass = File.basename(file, ".rb").singularize.classify.constantize
      if klass < ActiveRecord::Base
        puts "\n\n#{klass.to_s} [#{klass.count} records]"
        puts klass.pretty_table
      end
    end
  end

  desc "Show info for the specified db table"
  task :table, :name do |t, args|
    require 'config/environment'
    klass = args[:name].singularize.classify.constantize
    if klass < ActiveRecord::Base
      puts "#{klass.to_s} [#{klass.count} records]"
      puts klass.pretty_table
    end
  end

  desc "Show field names for the specified db table"
  task :fields, :name do |t, args|
    require 'config/environment'
    klass = args[:name].singularize.classify.constantize
    if klass < ActiveRecord::Base
      puts "#{klass.to_s} [#{klass.count} records]"
      fields ||= klass.content_columns.map(&:name)
      puts fields
    end
  end

  desc "List database tables that can be shown"
  task :list => :environment do
    Dir["app/models/**/*.rb"].each do |file|
      begin
        klass = File.basename(file, ".rb").singularize.classify.constantize
        if klass < ActiveRecord::Base
          puts klass
        end
      rescue

      end
    end
  end

end
