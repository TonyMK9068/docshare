When /^I go to register$/ do
  visit(sign_up_path)
end

When /^I fill in "[^\"]*" with "[^\"]*"$/ do |u, label, input|
  fill_in(label, with: input)
end

When /^I press "Sign up"$/ do
  click_link_or_button('Sign up')
end

Then /^I should see "[^\"]*" $/ do
  page.should have_css('login-notif')
end

Given /^I am not authenticated$/ do
  visit('/users/sign_out')
end