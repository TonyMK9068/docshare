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
  u = User.new(email: 'text@xample.com', password: 'helloworld', password_confirmation: 'helloworld', username: 'example')
  u.skip_confirmation!
  u.save 
  visit(new_user_session_path)
  fill_in 'Email', with: 'text@xample.com'
  fill_in 'Password', with: 'helloworld'
  click_button 'Sign in'
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