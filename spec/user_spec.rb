require 'spec_helper'

describe User do
  describe "#update_user_subscribed" do
    it "updates the user attribute :subscriber to true or false" do
      user = create(:user)
      user.update_user_subscribed
      user.subscriber.should be(true)
    end
  end
end