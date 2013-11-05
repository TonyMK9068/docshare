def create_page
  @page = FactoryGirl.create(:page)
  @page
end

Given /^I am logged in premium$/ do
  create_subscriber
  visit '/users/sign_in'
  fill_in "Email", :with => @user[:email]
  fill_in "Password", :with => @user[:password]
  click_button 'Sign in'
end

Given /^I have a page that is public$/ do
  @page = FactoryGirl.create(:page, :user => @user, :public => true)
end

Given /^I have a page that is private$/ do
  @page = FactoryGirl.create(:page, :user => @user, :public => false)
end

When /^I edit the page$/ do
  visit(edit_page_path(@page))
end

Then /^I can set it to private$/ do
  click_link("Privacy Settings")
  page.should have_content('Change privacy?')
end

Then /^I can set it to public$/ do
  click_on('Privacy Settings')
  page.should have_content('Change privacy?')
end

Then /^I can add collaborators$/ do
  click_on 'Add User'
  page.should have_content('Add collaborators by email or username')
end

Then /^I can authorize users that may view it$/ do
  click_on('Privacy Settings')
  click_on('Set Exceptions')
  page.should have_content('Please enter their username or email in the text box')
end