Given /^I am not signed in$/ do
  create_user
  visit ''
end

Given /^I am not registered$/ do
  create_visitor
  delete_user
end

When /^I visit the website$/ do
  visit(root_path)
end

Then /^I should see the (.*) link$/ do |selector|
  page.should have_content(selector)
end

Then /^I should not see the (.*) link$/ do |selector|
  page.should_not have link selector
end
