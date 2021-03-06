Given /^I have a premium account$/ do
  visit root_path
  create_subscriber
end

Given /^I have a credit card$/ do
  credit_card
end

When /^I upgrade to a premium account$/ do
  visit edit_user_registration_path
  click_on('Pay with Card')
  fill_in 'Card number', with: '4242424242424242'
  fill_in 'Expires', with: '04/15'
  fill_in 'Name on card', with: 'Some name'
  fill_in 'Card code', with: '456'
  click_button 'Pay $4.99'
end

When /^I enter valid credit card information$/ do
  visit edit_user_registration_path
  click_on('button.stripe-button-el')
  fill_in 'Card number', with: '4242424242424242'
  fill_in 'Expires', with: '07/14'
  fill_in 'Name on card', with: 'test user'
  fill_in 'Card code', with: '456'
  click_button 'Pay $4.99'
end

When /^I am not a premium user$/ do
  visit pages_path(pages = user.pages)
  page.has_no_css?('Subscription added successfully.')
end

Then /^I should see option to upgrade account$/ do
  page.has_content?('Upgrade Account?')
end

Then /^I can create private pages$/ do
  visit new_page_path
  page.has_button?('page_public_true')
end


Then /^I should have access to premium features$/ do
  page.has_content?('Subscription added successfully.')
end