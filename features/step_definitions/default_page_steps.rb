
Given /^user "(.+)" is not signed in$/ do |u|
  @current_user = User.find_by_username!(u)
  @current_user.user_signed_in? == false
end

Given /^user "(.+)" is signed in$/ do |u|
  @current_user = User.find_by_username!(u)
  @current_user.user_signed_in? == true
end

When /^user "(.+)" visits the website$/ do |u|
  visit(root_path)
end

Then /^user "(.+)" should see the "[^\"]*" link$/ do |u, selector|
  page.should have_css(selector)
end

Then /^user "(.+)" should not see the "[^\"]*" link$/ do |u, selector|
  page.should_not have_css(selector)
end
