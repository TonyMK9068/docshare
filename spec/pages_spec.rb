require 'spec_helper'

describe Page do

  describe "#add_collaborators( user_id = [] )" do
    it "adds user_ids to the attribute array :collaborators" do
      page = create(:page)
      user = create(:user)
      page.add_collaborators(:user.id)
      user.collaborators.last.should equal(:user.id)
    end
  end

  describe "#remove_collaborators( user_id = [] )" do
    it "Deletes collaborators with user_ids supplied in parameter" do
      page = create(:page)
      user = create(:user)
      page.remove_collaborators(:user.id)
      page.collaborators.include?(user_id).should equal(false)
    end
  end

  describe "#add_viewers( user_id = [] )" do
    it "adds user_ids to the attribute array :viewers" do
      page = create(:page)
      user = create(:user)
      page.add_viewers(:user.id)
      user.viewers.last.should equal(:user.id)
    end
  end

  describe "#remove_viewers( user_id = [] )" do
    it "Deletes viewers with user_ids supplied in parameter" do
      page = create(:page)
      user = create(:user)
      page.remove_viewers(:user.id)
      page.viewers.include?(user_id).should equal(false)
    end
  end
  
end
