When /^I click 'New Page'$/ do
  click_link 'New Page'
end

Then /^I should be redirected to a new wiki instance$/ do
  page.has_text?('Enter your data here...')
end

Given /^I am creating a new page$/ do
  visit(new_page_path)
end

When /^I enter markdown$/ do
  fill_in('Enter your data here...', :with => 'hello world')
end

Then /^I should see the text formatted in real time$/ do
  page.has_field?(p, :with => 'hello world')
end

Then /^I should be able to make it public$/ do
  choose('page_public_true')
end