Given /^I am logged in$/ do
  visit root_path
  create_user
  sign_in
  click_link('home')
  page.has_link?('account', visible: true) 
end

Given /^I am logged in with a premium account$/ do
  visit root_path
  create_subscriber
  sign_in
end

Given /^I visit the new user registration page$/ do
  visit new_user_registration_path
  page.has_button? 'Sign up'
end

Given /^I am not signed in$/ do
  create_user
  visit root_path
  page.has_link?('account', visible: false)
end

Given /^I am not registered$/ do
  @user = create_visitor
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
  sign_in
end

When /^I register without entering a username$/ do
  fill_in "user_email", :with => @user[:email]
  fill_in "user_password", :with => @user[:password]
  fill_in "user_password_confirmation", :with => @user[:password_confirmation]
  click_button 'Sign up'
end

When /^I register without entering a password$/ do
  fill_in "user_username", :with => @user[:username]
  fill_in "user_email", :with => @user[:email]
  fill_in "user_password_confirmation", :with => @user[:password_confirmation]
  click_button 'Sign up'
end

When /^I register without entering a password confirmation$/ do
  fill_in "user_username", :with => @user[:username]
  fill_in "user_email", :with => @user[:email]
  fill_in "user_password", :with => @user[:password]
  click_button 'Sign up'
end

When /^I register without entering an email$/ do
  fill_in "user_username", :with => @user[:username]
  fill_in "user_password", :with => @user[:password]
  fill_in "user_password_confirmation", :with => @user[:password_confirmation]
  click_button 'Sign up'
end

When /^I register with different password password_confirmation values$/ do
  fill_in "user_username", :with => @user[:username]
  fill_in "user_email", :with => @user[:email]
  fill_in "user_password", :with => @user[:password]
  fill_in "user_password_confirmation", :with => 'wrongentry'
  click_button 'Sign up'
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