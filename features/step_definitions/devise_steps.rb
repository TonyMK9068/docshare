def create_visitor
  @visitor ||= { :email => 'text@example.com', :username => 'Super Man', :password => 'testpass', :password_confirmation => 'testpass' }
end

def create_subscriber
  create_user
  @user.update_attributes(:subscriber => true)
  @user
end

def find_user
  @user ||= User.first conditions: { :email => @visitor[:email] }
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def delete_user
  find_user
  @user.destroy unless @user.nil?
end

def sign_up
  create_visitor
  delete_user
  visit '/users/sign_up'
  fill_in "Username", :with => @visitor[:username]
  fill_in "Email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button('Sign up')
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button 'Sign in'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

When /^I register with valid credentials$/ do
  sign_up
end

When /^I fill in (.*) with (.*)$/ do |label, input|
  fill_in(label.to_sym, with: input)
end

When /^I press 'sign up'$/ do
  click_link('Sign up')
end

When /^I log out$/ do
  click_link("log out")
end

When /^I sign in$/ do
  sign_in
end

Then /^I should see instructions to confirm account$/ do
  current_path.should == root_path
  page.should have_content('A message with a confirmation link has been sent to your email address. Please open the link to activate your account.')
end

Then /^I should see 'Signed out successfully.'$/ do
  page.should have_text('Signed out successfully.')
end

Then /^I should see 'Signed in successfully.'$/ do
  page.should have_text('Signed in successfully.')
end


