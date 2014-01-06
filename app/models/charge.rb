class Charge < ActiveRecord::Base
  belongs_to :user
  attr_accessible :customer_id

  def self.create_charge(customer)
    Stripe::Charge.create(amount: 499, currency: 'usd', description: 'Charge for DocShare subscrition', customer: customer)
  end
  
  def self.create_customer(token)
    Stripe::Customer.create(card: token)
  end
  
  def self.retreive_customer(user)
    Stripe::Customer.retrieve(user.charges.first.customer_id)
  end
  
  def self.retrieve_or_create_customer(token, user)
    if user.has_charges?
      Stripe::Customer.retrieve(user.charges.first.customer_id)
    else
      Charge.create_customer(token)
    end
  end
  
  def save_and_charge
    charge = self
    if charge.valid?
      Charge.create_charge charge.customer_id
      charge.save!
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to pages_path
    false
  end


end
