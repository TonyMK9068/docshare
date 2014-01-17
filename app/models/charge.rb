class Charge < ActiveRecord::Base
  belongs_to :user
  after_save :update_account
  
  validates_presence_of :user_id

  def subscriber_package
    Stripe::Charge.create(amount: 499, currency: 'usd', description: 'Charge for DocShare subscrition', customer: self.id)
  end
  
  private

  def update_account
    account = User.find self.user_id
    account.subscriber = true
    account.save
  end
end
