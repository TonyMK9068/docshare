When /^I go to register$/ do
  visit(new_user_registration_path)
end

When /^I fill in (.*) with (.*)$/ do |label, input|
  fill_in(label.to_sym, with: input)
end

When /^I press 'Sign up'$/ do
  click_link('Sign up')
end

Then /^I should see 'A message with a confirmation link...'$/ do
  page.has_text?('A message with a confirmation link has been sent to your email address. Please open the link to activate your account.')
end

Given /^I am logged in$/ do
  visit(new_user_session_path)
  fill_in 'Email', with: 'member@exampple.com'
  fill_in 'Password', with: 'helloworld'
  click_button 'Sign in'
  @user = User.where(:id => 1)
end

When /^I click 'Log out'$/ do
  click_link("Log out")
end

Then /^I should see 'Signed out successfully.'$/ do
  page.has_text?('Signed out successfully.')
end

Then /^I should see 'Signed in successfully.'$/ do
  page.has_text?('Signed in successfully.')
end


When /^I click 'Sign In'$/ do
  click_link("Sign In")
end