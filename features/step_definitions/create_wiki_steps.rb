Given /^I am creating a new page$/ do
  visit '/pages/new'
  page.has_text? 'Welcome to your new page!'
end

Given /^I have filled in all information for new page$/ do
  visit '/pages/new'
  within("form#new_page") do
    page.fill_in "page_title", :with => "hello test world"
    page.fill_in "page_body", :with => "test body test body test test"
  end
end
Given /^I have filled in the (.+) but not the (.+)$/ do |present, missing|
  visit '/pages/new'
  fill_in(present, :with => 'This test should fail.')
end

When /^I click 'New Page'$/ do
  visit '/pages/new'
  page.has_text? 'Welcome to your new page!'
end

When /^I click 'Save'$/ do
  click_link_or_button("Save Page")
end

When /^I enter markdown$/ do
  within("form#new_page") do
    fill_in 'page_title', :with => "hello test world"
    fill_in 'page_body', :with => 'markdowniscool hello world test test test'
  end
  #driver.browser.key_down(:a).key_up(:a).perform
end

Then /^I should be redirected to a new wiki instance$/ do
  page.has_content?('Welcome to your page!')
end

Then /^I should see the text formatted in real time$/ do
  page.has_css?('h1', :text => 'markdown is cool' )
end

Then /^I should see an error$/ do
  page.has_content?('Error saving page. Please try again')
end

Then /^the new page should be saved$/ do
  page.has_content?('Page created successfully')
end

