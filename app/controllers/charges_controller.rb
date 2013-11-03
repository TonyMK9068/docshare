class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 499

  customer = Stripe::Customer.create(
    :email => current_user.email,
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

  @customer = customer.id

    rescue Stripe::CardError => e
    flash[:error] = e.message
  end
end