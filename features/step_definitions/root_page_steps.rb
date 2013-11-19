When /^I visit the website$/ do
  visit root_path
end

Then /^I should see the (.*) link$/ do |selector|
  page.has_content?(selector, visible: true)
end

Then /^I should not see the (.*) link$/ do |selector|
  page.has_content?(selector, visible: false)
end