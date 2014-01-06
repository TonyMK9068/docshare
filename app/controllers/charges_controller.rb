class ChargesController < ApplicationController
  def create
    token = params[:stripeToken]
    @user = current_user
    @customer = Charge.retrieve_or_create_customer(token, @user)
    @charge = @user.charges.build(customer_id: @customer.id)

    authorize! :create, Charge, message: 'Not authorized to make payment'

    if @charge.save && 
      @customer.update_subscription(plan: 'docshare-subscription', prorate: true)
      flash[:notice] = 'Subscription added successfully. Log back in for changes to take effect'
      redirect_to pages_path
    else
      flash[:error] = 'Charge not successful'
      render '/'
    end
  end

  def destroy
    @user = current_user
    @charge = Charge.find(params[:id])
    @customer = Charge.retreive_customer @user

    authorize! :destroy, @charge, message: 'You are not authorized to cancel this subscription.'

    @customer.cancel_subscription(at_period_end: true)
    if @customer.subscription[:canceled_at]
      flash[:notice] = 'Subscription canceled successfully'
      redirect_to '/pages'
    else
      flash[:error] = 'Error canceling subscription. Please try again.'
      redirect_to '/pages'
    end
  end
end