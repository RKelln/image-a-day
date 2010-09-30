Given /^I have a user "([^"]*)" with nickname "([^"]*)" and password "([^"]*)"$/ do |user, nickname, password|
    Factory.create(:user, :email => user, :nickname => nickname, :password => password)
end

Given /^I am logged in$/ do
    password = "password"
    user = Factory.create(:user, :password => password)
    When  %{I go to the home page}
    When  %{I fill in "Email" with "#{user.email}"}
    And   %{I fill in "Password" with "#{password}"}
    And   %{I press "Sign in"}
end
