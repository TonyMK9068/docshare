Given /^I am creating a new page$/ do
  visit(new_page_path)
end

Given /^I have filled in all information for new page$/ do
  visit '/pages/new'
  fill_in(:page_title, :with => "hello world")
  fill_in(:page_body, :with => "#markdown is cool")
end

Given /^I have filled in the (.+) but not the (.+)$/ do |present, missing|
  visit '/pages/new'
  fill_in(present.to_sym, :with => 'This test should fail.')
end

When /^I click 'New Page'$/ do
  visit '/pages'
  click_link 'new page'
end

When /^I click 'Save'$/ do
  click_button 'Save'
end

When /^I enter markdown$/ do
  fill_in(:page_title, :with => "hello world")
  fill_in(:page_body, :with => '#markdowniscool')
  page.driver.browser.key_down(:a).key_up(:a).perform
end

Then /^I should be redirected to a new wiki instance$/ do
  page.should have_text('Welcome to your page!')
end

Then /^I should see the text formatted in real time$/ do
  page.should have_css('h1', :text => 'markdown is cool' )
end

Then /^I should be able to make it public$/ do
  choose('page_public_true')
end

Then /^I should see an error$/ do
  page.should have_text('Error saving page. Please try again')
end

Then /^the new page should be saved$/ do
  page.should have_text(:visible, 'Page created successfully')
end

