# This file is used by Rack-based servers to start the application.

# Ruby 1.9.2 path fix
$LOAD_PATH << '.' unless $LOAD_PATH.include?('.')
require ::File.expand_path('../config/environment',  __FILE__)
run ImageADay::Application
