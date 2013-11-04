def create_page
  @page = FactoryGirl.create(:page)
end

Given /^I am logged in premium$/ do
  sign_in
end

Given /^I have a page that is public$/ do
  create_page
  @page.update_attributes(:user => @user)
end

Given /^I have a page that is private$/ do
  create_page
  @page.update_attributes(:user => @user, :public => false)
end

When /^I edit the page$/ do
  visit 'pages/index'
  click_button('Edit')
end

Then /^I can set it to private$/ do
  click_button('Private')
  page.should have_content('Page is now private')
end

Then /^I can set it to public$/ do
  click_button('Public')
  page.should have_content('Page is now public')
end

Then /^I can add collaborators$/ do
  click_button('Add users')
  page.should have_content('Submit users by email username')
end

Then /^I can authorize users that may view it$/ do
  click_button('Privacy Settings')
  page.should have_content('Submimt users who may view this page')
end