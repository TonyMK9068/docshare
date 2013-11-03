class ChargesController < ApplicationController
  after_filter :update_user

  def create
    # Amount in cents
    @amount = 499
    @user = current_user

    authorize! :create, Stripe::Charge, message: "Not authorized to make charge"

    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => params[:stripeToken],
      :plan => 'basic',
      :metadata => { :user => current_user.id }
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    rescue Stripe::CardError => e
    flash[:error] = e.message
    

  end

  private

  def update_user 
    current_user.update_attributes(:subscriber => true)
  end
end