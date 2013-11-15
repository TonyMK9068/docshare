require 'spec_helper'

  def user_setup
    @user1, @user2, @user3 = create(:user), create(:user), create(:user)

    @page1 = @user1.pages.create(attributes_for(:page))
    @page2 = @user2.pages.create(attributes_for(:page))

    @role1 = Role.new(:user_id => @user1.id, :status => 'owner', :page_id => @page1.id)
    @role1.save
    @role2 = Role.new(:user_id => @user1.id, :status => 'collaborator', :page_id => @page2.id)
    @role2.save
    @role3 = Role.new(:user_id => @user1.id, :status => 'viewer', :page_id => @page2.id)
    @role3.save
    @role4 = Role.new(:user_id => @user2.id, :status => 'owner', :page_id => @page2.id)
    @role4.save
    @role5 = Role.new(:user_id => @user3.id, :status => 'viewer', :page_id => @page1.id)
    @role5.save
    @role6 = Role.new(:user_id => @user3.id, :status => 'collaborator', :page_id => @page2.id)
    @role6.save
  end

describe User do

  describe "#owners" do

    before(:each) do
      user_setup
    end 

    it "returns instances where attribute :status => 'owner'" do
      @user1.owners.should =~ [@role1]
    end

    it "does not return instances where :status does not match 'owner'" do
      @user1.owners.should_not include(@role2, @role3, @role4, @role5, @role6)
    end
  end

  describe "#collaborators" do
    before(:each) do
      user_setup
    end 

    it "returns instances where attribute :status => 'collaborator'" do
      @user1.collaborators.should =~ [@role2]
    end

    it "does not return instances where :status does not match 'collaborator'" do
      @user1.collaborators.should_not include(@role1, @role3, @role4, @role5, @role6)
    end
  end

  describe "#viewers" do
    before(:each) do
      user_setup
    end 

    it "returns instances where attribute :status => 'viewer'" do
      @user1.viewers.should =~ [@role3]
    end

    it "does not return instances where :status does not match 'viewer'" do
      @user1.viewers.should_not include(@role1, @role2, @role4, @role5, @role6)
    end
  end

  describe "validates presence of both username and email" do
    it "fails when saving an instance without a username" do
      user = User.new(email: 'test@example.com', :password => 'helloworld', :password_confirmation => 'helloworld')
      user.skip_confirmation!
      user.save.should equal false
    end

    it "fails when saving an instance without an email" do
      user = User.new(:username => 'tester', :password => 'helloworld', :password_confirmation => 'helloworld')
      user.skip_confirmation!
      user.save.should equal false
    end

    it "succeeds when saving an instance with username and email" do
      user = User.new(:email => 'text@example.com', :username => 'tester', :password => 'helloworld', :password_confirmation => 'helloworld')
      user.skip_confirmation!
      user.save.should equal true
    end
  end

  describe "validates username must be atleast 6 characters long" do
    it "fails when username is less than 6" do
      user = User.new(:email => 'text@example.com', :username => 'test', :password => 'helloworld', :password_confirmation => 'helloworld')
      user.skip_confirmation!
      user.save.should equal false
    end

    it "succeeds when username is 6 characters" do
      user = User.new(:email => 'text@example.com', :username => 'tester', :password => 'helloworld', :password_confirmation => 'helloworld')
      user.skip_confirmation!
      user.save.should equal true
    end

    it "succeeds when username is more than 6 characters" do
      user = User.new(:email => 'text@example.com', :username => 'testasding', :password => 'helloworld', :password_confirmation => 'helloworld')
      user.skip_confirmation!
      user.save.should equal true

    end
  end
end