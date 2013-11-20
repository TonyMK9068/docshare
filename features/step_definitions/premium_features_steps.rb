Given /^I have a page that is public$/ do
  create_page
  @page
end

Given /^I have a page that is private$/ do
  @page = Page.new(title: "hello world hello world", body: "hello test testtest test test test test test", public: false, slug: "hello-world-hello-world")
  role = Role.create(page_id: 1, user_id: 1, status: 'owner')
  @page.save!
end

When /^I am at the edit page view$/ do
  visit(edit_page_path(@page))
  current_path.should == edit_page_path(@page)
end

Then /^I can select Page Settings$/ do
  page.has_button? "Page Settings"
end

#Then /^I can set it to private$/ do
#  page.has_content?('Change privacy below:')
#end

#Then /^I can set it to public$/ do
#  page.has_content?('Change privacy below:')
#end

#Then /^I can add collaborators$/ do
#  page.has_button?('Add Collaborator')
#end

#Then /^I can authorize users that may view it$/ do
#  page.has_button?('Add Viewer')
#end

