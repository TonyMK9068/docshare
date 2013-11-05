require 'spec_helper'

def set_defaults
  @page = nil
  @page = create(:page)
  @user = nil
  @user = create(:user)
end


describe Viewer do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "#find_user(input)" do
    it "takes user emails as argument and returns associated user id" do
      set_defaults
      find_user(@user[input]).should equal 1
    end
    
    it "takes usernames as arguments and returns associated user id" do
      set_defaults
      find_user(@user[input]).should equal 1
    end
  end

end
