source 'http://rubygems.org'

gem 'rails', '~> 3.2'

gem 'pg'

gem 'haml'
gem 'haml-rails'

# authentication
gem 'devise'

# models with file attachments
gem 'paperclip'

# asset packaging
gem 'jammit'

# pagination
gem 'will_paginate'

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Compass/sass/and other css frameworks
gem 'compass', '>= 0.10.5'
gem 'compass-susy-plugin'
gem 'html5-boilerplate'

group :development, :test do
  #gem 'ruby-debug19'
  # rails console luxury (colors, tab completion)
  gem 'wirble'

  gem 'thin'
end

group :test do
  gem 'capybara', '< 0.4.0'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'factory_girl', :require => nil
  gem 'factory_girl_rails'
  gem 'cucumber_factory'
#  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'timecop'
end
