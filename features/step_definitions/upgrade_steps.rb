def credit_card
  @card ||= { paymentNumber: '4242424242424242', paymentCVC: '456', paymentName: 'Test User', paymentExpiry: '07 / 14' }
end

Given /^I have a premium account$/ do
  create_subscriber
end

Given /^I have a credit card$/ do
  credit_card
end

When /^I upgrade to a premium account$/ do
  visit(pages_path)
  click_button 'button.stripe-button-el'
  fill_in 'Card number', with: '4242424242424242'
  fill_in 'Expires', with: '04/15'
  fill_in 'Name on card', with: 'Some name'
  fill_in 'Card code', with: '456'
  click_button 'Pay $4.99'
end

When /^I enter valid credit card information$/ do
  visit '/pages'
  click_button 'stripe-button'
  fill_in 'Card number', with: @card[:paymentNumber]
  fill_in 'Expires', with: @card[:paymentExpiry]
  fill_in 'Name on card', with: @card[:paymentName]
  fill_in 'Card code', with: @card[:paymentCVC]
  click_button 'Pay $4.99'
end

When /^I am not a premium user$/ do
  visit '/pages'
  page.should_not have_css('.charge-success')
end

Then /^I should see option to upgrade account$/ do
  page.should have_text('Upgrade Account?')
end

Then /^I can create private pages$/ do
  visit(new_page_path)
  page.should have_button('page_public_true')
end

Then /^I am upgraded to a premium account$/ do
  visit(pages_path)
  page.should have_css('.charge-success')
end
