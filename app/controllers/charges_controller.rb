class ChargesController < ApplicationController
  
####### helper methods ######
  def create_charge(customer)
    payment = Stripe::Charge.create(
    :amount => 499,
    :currency => "usd",
    :description => "Charge for DocShare subscrition",
    :customer => customer.id )
  end

  def create_customer(token)
    customer = Stripe::Customer.create(:card  => token )
  end

######controller actions ######

  def create
    tokens = params[:stripeToken]
    if current_user.charges.length == 0
      @customer = create_customer(tokens)
    else
      @id = current_user.charges.first.customer_id
      @customer = Stripe::Customer.retrieve(@id)
    end
    
    @charge = current_user.charges.build(customer_id: @customer.id)
    authorize! :create, Stripe::Charge, message: "Not authorized to make payment"
    if @charge.save
      create_charge(@customer)
      @customer.update_subscription(:plan => "docshare-subscription", :prorate => true)
      flash[:notice] = "Subscription added successfully. Please log back in for changes to take effect"
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
    @charge = Charge.find(params[:id])
    @id = current_user.charges.last.customer_id
    @customer = Stripe::Customer.retrieve(@id)
    authorize! :destroy, @charge, message: "You are not authorized to cancel this subscription."
    @customer.cancel_subscription(:at_perod_end => true)
    if @customer.subscription.at_period_end == true
      flash[:notice] = "Subscription canceled successfully"
      redirect_to pages_path
    else
      flash[:error] = "Error canceling subscription. Please try again."
      render pages_path
    end
  end

end
