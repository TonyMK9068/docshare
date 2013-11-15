require 'spec_helper'
  
describe Role do

  describe "ensures the same status is not repeated for the same user and page" do
    
    before(:each) do
      @user = create(:user)
      @page = create(:page)
      @role1 = @user.roles.create(:page_id => @page, :status => 'viewer')
    end 

    it 'fails when role is repeated for page and user combination' do
      role2 = @user.roles.create(:page_id => @page, :status => 'viewer')
      role2.save.should equal false
    end

    it 'succeeds when creating a unique role' do
      role2 = @user.roles.create(:page_id => @page, :status => 'status')
      role2.save.should equal true
    end
  end
end

