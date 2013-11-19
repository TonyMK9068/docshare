Given /^I am creating a new page$/ do
  page.find(:css, "a#new-page", visible: true).click
end

Given /^I have filled in all information for new page$/ do
  visit root_path
  puts page.body
  page.find('#new-page', visible: true).click
  fill_in('page_title', :with => "hello test world")
  fill_in('page_body', :with => "test body test body test test")
end

Given /^I have filled in the (.+) but not the (.+)$/ do |present, missing|
  visit root_path
  puts page.body
  page.find('#new-page', visible: true).click
  fill_in(present, :with => 'This test should fail.')
end

When /^I click 'New Page'$/ do
  visit root_path
  puts page.body
  page.find('#new-page', visible: true).click
end

When /^I click 'Save'$/ do
  click_link_or_button("save", :exact => false)
end

When /^I enter markdown$/ do
  fill_in('page_title', :with => "hello world")
  fill_in('page_body', :with => 'markdowniscool hello world')
  driver.browser.key_down(:a).key_up(:a).perform
end

Then /^I should be redirected to a new wiki instance$/ do
  page.has_content?('Welcome to your page!')
end

Then /^I should see the text formatted in real time$/ do
  page.has_css?('h1', :text => 'markdown is cool' )
end

Then /^I should be able to make it public$/ do
  choose('page_public_true')
end

Then /^I should see an error$/ do
  page.has_content?('Error saving page. Please try again')
end

Then /^the new page should be saved$/ do
  page.has_content?('Page created successfully', visibl: true)
end

