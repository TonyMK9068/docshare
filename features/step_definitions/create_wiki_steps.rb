When /^I click 'Create new wiki'$/ do
  click_button 'Create new wiki'
end

Then /^I should be redirected to a new wiki instance$/ do
  has_text?('Enter your data here...')
end