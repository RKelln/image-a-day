When /^I fill in "([^"]*)" with "([^"]*)" for user "([^"]*)"$/ do |field, value, user|
  user = User.where(:nickname => user).first
  with_scope("#edit_user_#{user.id}") do
    fill_in(field, :with => value)
  end
end

When /^I press "([^"]*)" for user "([^"]*)"$/ do |button, user|
  user = User.where(:nickname => user).first
  with_scope("#edit_user_#{user.id}") do
    click_button(button)
  end
end
