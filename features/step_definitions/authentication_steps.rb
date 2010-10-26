Given /^I am logged in$/ do
    password = "password"
    @user = Factory.create(:user, :password => password)
    When  %{I go to the home page}
    When  %{I fill in "Email" with "#{@user.email}"}
    And   %{I fill in "Password" with "#{password}"}
    And   %{I press "Sign in"}
end

Given /^I am logged in as an admin$/ do
    password = "password"
    @user = Factory.create(:admin, :password => password)
    When  %{I go to the home page}
    When  %{I fill in "Email" with "#{@user.email}"}
    And   %{I fill in "Password" with "#{password}"}
    And   %{I press "Sign in"}
end

# magic factory for logged in user
Given /^I have a (\w+)(?: with (.*))?$/ do |factory,traits|
    Given %{there is a #{factory} with the user id "#{@user.id}"#{' and ' + traits if traits}}
end
