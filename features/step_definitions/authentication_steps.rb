Given /^I have a user "([^"]*)" with nickname "([^"]*)"(?: and password "([^"]*)")?$/ do |email, nickname, password|
    user_params = {}
    user_params[:email] = email
    user_params[:nickname] = nickname
    user_params[:password] = password if password
    Factory.create(:user, user_params)
end

Given /^I am logged in$/ do
    password = "password"
    user = Factory.create(:user, :password => password)
    When  %{I go to the home page}
    When  %{I fill in "Email" with "#{user.email}"}
    And   %{I fill in "Password" with "#{password}"}
    And   %{I press "Sign in"}
end

Given /^I am logged in as an admin$/ do
    password = "password"
    user = Factory.create(:admin, :password => password)
    When  %{I go to the home page}
    When  %{I fill in "Email" with "#{user.email}"}
    And   %{I fill in "Password" with "#{password}"}
    And   %{I press "Sign in"}
end
