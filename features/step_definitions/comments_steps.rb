Given /^I have a comment saying "([^"]*)"$/ do |text|
    Factory.create(:comment, :text => text)
end
