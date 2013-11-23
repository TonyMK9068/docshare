Given /^I am logged in with a standard account$/ do
  create_user
  visit '/users/sign_in'
  sign_in
  click_link('home')
end

Given /^I am logged in with a premium account$/ do
  create_subscriber
  visit '/users/sign_in'
  sign_in
  click_link('home')
end

Given /^I visit the new user registration page$/ do
  visit new_user_registration_path
  page.has_button? 'Sign up'
end

Given /^I am not signed in$/ do
  current_user = create_user
  visit root_path
  page.has_link?('account')
end

Given /^I am not registered$/ do
  current_user = create_visitor
end

When /^I input valid credentials$/ do
  fill_sign_up_form
end

When /^I fill in (.*) with (.*)$/ do |label, input|
  fill_in(label, with: input)
end

When /^I press 'sign up'$/ do
  click_button("Sign up")
end

When /^I log out$/ do
  click_link_or_button "account"
  click_link 'log out'
end

When /^I sign in$/ do
    visit '/users/sign_in'
  sign_in
end

When /^I register without entering a username$/ do
  fill_in "user_email", :with => 'member@example.com'
  fill_in "user_password", :with => 'helloworld'
  fill_in "user_password_confirmation", :with => 'helloworld'
  click_button 'Sign up'
end

When /^I register without entering a password$/ do
  fill_in "user_username", :with => 'testmember'
  fill_in "user_email", :with => 'member@example.com'
  fill_in "user_password_confirmation", :with => 'helloworld'
  click_button 'Sign up'
end

When /^I register without entering a password confirmation$/ do
  fill_in "user_username", :with => 'testmember'
  fill_in "user_email", :with => 'member@example.com'
  fill_in "user_password", :with => 'helloworld'
  click_button 'Sign up'
end

When /^I register without entering an email$/ do
  fill_in "user_username", :with => 'testmember'
  fill_in "user_password", :with => 'helloworld'
  fill_in "user_password_confirmation", :with => 'helloworld'
  click_button 'Sign up'
end

When /^I register with different password password_confirmation values$/ do
  fill_in "user_username", :with => 'testmember'
  fill_in "user_email", :with => 'member@example.com'
  fill_in "user_password", :with => 'helloworld'
  fill_in "user_password_confirmation", :with => 'wrongentry'
  click_button 'Sign up'
end

When /^I visit the website$/ do
  visit root_path
end

Then /^I should see instructions to confirm account$/ do
  page.has_text?('A message with a confirmation link has been sent to your email address. Please open the link to activate your account.')
end

Then /^I should see 'Signed out successfully.'$/ do
  page.has_text?('Signed out successfully')
end

Then /^I should see 'Signed in successfully.'$/ do
  page.has_text?('Signed in successfully')
end

Then /^I should see a registration error$/ do
  page.has_text?('errors prohibited this user from being saved')
end

Then /^I should be redirected to my page index$/ do
  page.has_text? 'Select a page from below to view or edit:'
end

Then /^I should be redirected to the home page$/ do
  page.has_text? 'Welcome to DocShare'
end


Then /^I should see the (.*) link$/ do |selector|
  page.has_content?(selector, visible: true)
end

Then /^I should not see the (.*) link$/ do |selector|
  page.has_content?(selector, visible: false)
end
