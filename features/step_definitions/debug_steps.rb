require 'ruby-debug' # Allow debugger in steps

Then /^(?:|I )debug$/ do
  debugger
  stop_here = 1
end
