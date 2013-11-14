require 'spec_helper'

describe Page do
  

  describe "#page_role_instances(association)" do
    
    before(:each) do
      user1, user2, user3 = create(:user), create(:user), create(:user)

      @page = user1.pages.create(attributes_for(:page))
      @page.roles.create(:status => 'owner', :user_id => 1)
      @page.roles.create(:status => 'viewer', :user_id => 2 )
      @page.roles.create(:status => 'collaborator', :user_id => 2)
      @page.roles.create(:status => 'viewer', :user_id => 3)
    end

    it "returns an array of Role instances" do 
      @page.page_role_instances('owner').first.is_a?(Role).should equal true
    end

    it "returns an array of Role instances belonging to page with :status => owner when argument set to owner" do
      @page.page_role_instances('owner').should =~ Role.joins(:user).where(:status => 'owner', :page_id => @page.id)
    end

    it "returns an array of Role instances belonging to page with :status => owner when argument set to viewer" do
      @page.page_role_instances('viewer').should =~ Role.joins(:user).where(:status => 'viewer', :page_id => @page.id)
    end

    it "returns an array of Role instances belonging to page with :status => owner when argument set to collaborator" do
      @page.page_role_instances('collaborator').should =~ Role.joins(:user).where(:status => 'collaborator', :page_id => @page.id)
    end

    it "does not return Role instances where status is owner and argument is viewer" do
      @page.page_role_instances('viewer').should_not =~ Role.joins(:user).where(:status => 'owner', :page_id => @page.id)
    end

    it "does not return Role instances where status is owner and argument is collaborator" do
      @page.page_role_instances('collaborator').should_not =~ Role.joins(:user).where(:status => 'owner', :page_id => @page.id)
    end

    it "does not return Role instances where status is viewer and argument is collaborator" do
      @page.page_role_instances('collaborator').should_not =~ Role.joins(:user).where(:status => 'viewer', :page_id => @page.id)
    end

    it "does not return Role instances where status is viewer and argument is owner" do
      @page.page_role_instances('owner').should_not =~ Role.joins(:user).where(:status => 'viewer', :page_id => @page.id)
    end

    it "does not return Role instances where status is collaborator and argument is owner" do
      @page.page_role_instances('owner').should_not =~ Role.joins(:user).where(:status => 'collaborator', :page_id => @page.id)
    end

    it "does not return Role instances where status is collaborator and argument is viewer" do
      @page.page_role_instances('viewer').should_not =~ Role.joins(:user).where(:status => 'collaborator', :page_id => @page.id)
    end
  end

# remove
  describe "#user_instances(association)" do
    before(:each) do
      @page = nil
      user1, user2, user3 = create(:user), create(:user), create(:user)

      @page = user1.pages.create(attributes_for(:page))
      @page.roles.create(:status => 'owner', :user_id => 1)
      @page.roles.create(:status => 'viewer', :user_id => 2 )
      @page.roles.create(:status => 'collaborator', :user_id => 2)
      @page.roles.create(:status => 'viewer', :user_id => 3)
    end

    it "returns an array of User instances" do
      @page.user_instances('owner').first.is_a?(User).should equal true
    end

    it "returns User instances that belong to page through a role with status owner when owner is used as argument" do
      @page.user_instances('owner').should =~ [ User.find_by_id(1) ]
    end

    it "returns User instances that belong to page through a role with status viewer when viewer is used as argument" do
      @page.user_instances('viewer').should =~ [ User.find_by_id(2), User.find_by_id(3) ]
    end  

    it "returns User instances that belong to page through a role with status collaborator when collaborator is used as argument" do
      @page.user_instances('collaborator').should =~ [ User.find_by_id(2) ]
    end

    it "only return User instances for Roles if status and arg match" do
      @page.user_instances('owner').should_not =~ [ User.find_by_id(2), User.find_by_id(3) ]
    end
  end

#redescribe
  describe '#create_role(user)' do
    
    before(:each) do
      @page = nil
      user1, user2 = create(:user), create(:user)
      @user1 = User.find_by_id(1)
      @user2 = User.find_by_id(2)

      @page = user1.pages.create(attributes_for(:page))
      @page.roles.create(:status => 'owner', :user_id => 1)
      @page.roles.create(:status => 'viewer', :user_id => 2 )
      @page.roles.create(:status => 'collaborator', :user_id => 2)
      @page.roles.create(:status => 'viewer', :user_id => 3)
    end

page.owners should include (user)

    it "creates a new Role instance" do
      role = @page.create_role(@user1)
      role.is_a?(Role).should equal true
    end

    it "creates a Role instance with instance[:status] = 'owner' " do
      role = @page.create_role(@user1)
      role[:status].should match 'owner'
    end

    it "does not create a Role instance with instance[:status] = 'viewer' " do
      role = @page.create_role(@user1)
      role[:status].should_not match 'viewer'
    end

    it "does not create a Role instance with instance[:status] = 'collaborator' " do
      role = @page.create_role(@user1)
      role[:status].should_not match 'collaborator'
    end

    it "creates Role instance with user_id equal to user instance supplied in argument" do
      role = @page.create_role(@user1)
      role[:user_id].should equal 1
    end

    it "does not create Role instance with user_id not equal to user instance supplied in argument" do
      role = @page.create_role(@user2)
      role[:user_id].should_not equal 1
    end
  end

  describe 'instances of Page must contain values for body, title, and slug attributes' do

    it 'fails when saving page without body' do
      page = Page.new(:title => 'test title', :slug => 'test-title')
      page.save.should equal false
    end

    it 'fails when saving page without title' do
      page = Page.new(:body => 'test title', :slug => 'test-slug')
      page.save.should equal false
    end

    it 'creating new instance succeeds withn page, title and slug are all present' do
      page = Page.new(:body => 'test title', :slug => 'test-slug', :title => 'test slug')
      page.save.should equal true
    end
  end

  describe 'Slug entrees must be unique' do

    it 'slug fails validation when matching another slug db entry' do
    end

    it 'passes validation when slug is unique' do
    end
  end

  describe 'Body attribute must be atleast 15 characters long' do

    it 'new instance fails validation when body is less than 15 characters long' do
    end

    it 'new instance passes validationwhen body is exactly 15 characters long' do
    end

    it 'new instance passes validation when body is greater than 15 characters long' do
    end
  end

  describe 'Body attribute must be atleast 8 characters long' do

    it 'new instance fails validation when body is less than 8 characters long' do
    end

    it 'new instance passes validationwhen body is exactly 8 characters long' do
    end

    it 'new instance passes validation when body is greater than 8 characters long' do
    end
  end
end