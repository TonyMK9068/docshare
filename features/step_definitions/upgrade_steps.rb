When /^I upgrade to a premium account$/ do
  visit(edit_user_registration_path)
  click_button('Subscribe')
end

Then /^I can create private pages$/ do
  visit(new_page_path)
  choose('page_public_false')
end