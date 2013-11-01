Given /^I am not signed in$/ do
  page.driver.submit :delete, "/users/sign_out", {}
end


When /^I visit the website$/ do
  visit(root_path)
end

Then /^I should see the (.*) link$/ do |selector|
  page.has_link?('#{selector}')
end

Then /^I should not see the (.*) link$/ do |selector|
  page.has_no_selector?('#{selector}')
end
