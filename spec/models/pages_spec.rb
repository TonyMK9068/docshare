require 'spec_helper'

describe Page do
     
  describe "#owners" do

    before(:each) do
      user1, user2, user3 = create(:user), create(:user), create(:user)

      @page = user1.pages.create(attributes_for(:page))

      @role1 = @page.roles.create(:status => 'owner', :user_id => 1)
      @role2 = @page.roles.create(:status => 'viewer', :user_id => 2 )
      @role3 = @page.roles.create(:status => 'collaborator', :user_id => 2)
      @role4 = @page.roles.create(:status => 'viewer', :user_id => 3)
    end 

    it "returns instances where attribute :status => 'owner'" do
      @page.owners.should =~ [@role1]
    end

    it "does not return instances where :status does not match 'owner'" do
      @page.owners.should_not include(@role2, @role3, @role4)
    end
  end

  describe "#collaborators" do
    before(:each) do
      user1, user2, user3 = create(:user), create(:user), create(:user)

      @page = user1.pages.create(attributes_for(:page))

      @role1 = @page.roles.create(:status => 'owner', :user_id => 1)
      @role2 = @page.roles.create(:status => 'viewer', :user_id => 2 )
      @role3 = @page.roles.create(:status => 'collaborator', :user_id => 2)
      @role4 = @page.roles.create(:status => 'viewer', :user_id => 3)
    end 

    it "returns instances where attribute :status => 'collaborator'" do
      @page.collaborators.should =~ [@role3]
    end

    it "does not return instances where :status does not match 'collaborator'" do
      @page.collaborators.should_not include(@role1, @role2, @role4)
    end
  end

  describe "#viewers" do
        before(:each) do
      user1, user2, user3 = create(:user), create(:user), create(:user)

      @page = user1.pages.create(attributes_for(:page))

      @role1 = @page.roles.create(:status => 'owner', :user_id => 1)
      @role2 = @page.roles.create(:status => 'viewer', :user_id => 2 )
      @role3 = @page.roles.create(:status => 'collaborator', :user_id => 2)
      @role4 = @page.roles.create(:status => 'viewer', :user_id => 3)
    end 

    it "returns instances where attribute :status => 'viewer'" do
      @page.viewers.should =~ [@role2, @role4]
    end

    it "does not return instances where :status does not match 'viewer'" do
      @page.viewers.should_not include(@role1, @role3)
    end
  end

  describe "#set_owner(user)" do

    it "creates a role instance with :status => 'owner' belonging to user" do
      user = create(:user)
      page = create(:page)
      page.owners.should include(page.set_owner(user))
    end
  end

  describe 'validates presence of body, and title' do

    it 'fails when creating without body' do
      page = Page.new(:title => 'test title')
      page.save.should eql(false)
    end

    it 'fails when creating without title' do
      page = Page.new(:body => 'hello world hello world')
      page.save.should eql false
    end

    it 'succeeds when title and body are all present' do
      page = Page.new(:body => 'hello world hello world', :title => 'hello worldasdadad')
      page.save.should eql true
    end
  end

  describe "#number_of_versions", :versioning => true do
    it "returns how many versions exist for a page, ignoring creation event" do
      page = create(:page)
      page.update_attribute(:body, 'test body one')
      page.update_attribute(:body, 'test new body')
      page.number_of_versions.should == 2
    end
  end

  describe 'Page body must be atleast 15 characters long' do

    it 'new instance fails validation when body is less than 15 characters long' do
      page = Page.new(:title => 'hello world', :body => 'short')
      page.save.should equal false
    end

    it 'new instance passes validation when body is exactly 15 characters long' do
      page = Page.new(:title => 'hello world', :body => 'four four four 123!')
      page.save.should equal true
    end

    it 'new instance passes validation when body is greater than 15 characters long' do
      page = Page.new(:title => 'hello world', :body => 'much longer than fifteen characters')
      page.save.should equal true
    end
  end

  describe 'Page title must be atleast 6 characters long' do

    it 'new instance fails validation when body is less than 8 characters long' do
      page = Page.new(:title => 'four', :body => 'testing testing testing')
      page.save.should equal false
    end

    it 'new instance passes validation when body is exactly 8 characters long' do
      page = Page.new(:title => '12345678', :body => 'testing testing testing')
      page.save.should equal true
    end

    it 'new instance passes validation when body is greater than 8 characters long' do
      page = Page.new(title: 'fourfourfour', body: 'testing testing testing')
      page.save.should equal true
    end
  end
end