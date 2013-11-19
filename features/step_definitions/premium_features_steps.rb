Given /^I have a page that is public$/ do
  create_page
end

Given /^I have a page that is private$/ do
  Page.destroy_all
  page = Page.new(title: "hello world hello world", 
                          body: "hello test testtest test test test test test",
                          public: false)
  page.save!
end

When /^I edit the page$/ do
  visit(edit_page_path(@page))
  page.has_content?('Edit content or settings for:')
end

Then /^I can set it to private$/ do
  
  click_button("Page Settings", visible: true)
  page.has_content?('Change privacy below:')
end

Then /^I can set it to public$/ do
  click_button('Page Settings', visible: true)
  page.has_content?('Change privacy below:')
end

Then /^I can add collaborators$/ do
  click_button('Page Settings', visible: true)
  page.has_button?('Add Collaborator')
end

Then /^I can authorize users that may view it$/ do
  click_on('Page Settings')
  page.has_button?('Add Viewer')
end