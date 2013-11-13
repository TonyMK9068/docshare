class Charge < ActiveRecord::Base
  belongs_to :user
  attr_accessible :customer_id, :success, :user

  after_create :update_user

  def update_user
    id = current_user.charges.last.customer_id
    customer = Stripe::Customer.retrieve(id)
    if customer.subscription[:status] == "active"
      current_user.update_attribute(:subscriber => true)
    end
  end
end
