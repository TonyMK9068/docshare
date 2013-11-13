class ChargesController < ApplicationController
  before_filter :setup_action
  
####### method helpers ######
  def create_charge(token)
    payment = Stripe::Charge.create(
    :amount => 499,
    :currency => "usd",
    :card => token, # obtained with Stripe.js
    :description => "Charge for DocShare subscrition"
    )
  end

  def create_customer(token)
    customer = Stripe::Customer.create(
                :card  => token )
  end

######controller actions ######

  def create
    if current_user.charges.length == 0
      @customer = create_customer(@token)
    else
      @id = current_user.charges.first.customer_id
      @customer = Stripe::Customer.retrieve(@id)
    end
    
    @charge = current_user.charges.build(customer_id: @customer.id)
    authorize! :create, Stripe::Charge, message: "Not authorized to make payment"
    if @charge.save
      create_charge(@token)
      @customer.update_subscription(:plan => "docshare-subscription", :prorate => true)
      flash[:notice] = "Subscription added successfully."
      redirect_to pages_path
    else
      flash[:error] ="Error making charge. Please try again."
      render root_path
    end
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to pages_path
  end


  def destroy
    @id = current_user.charges.first.customer_id
    @customer = Stripe::Customer.retrieve(@id)
    @customer.cancel_subscription(:at_perod_end => true)
  end

  private

  def setup_action
    @token = params[:stripeToken]
  end
end
