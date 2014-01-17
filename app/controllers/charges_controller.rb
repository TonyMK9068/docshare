class ChargesController < ApplicationController
  def create
    @user = current_user
    
    authorize! :create, Charge, message: 'Not authorized to make payment'
    @charge = Charge.new
    @charge.user_id = @user.id
    Charge.transaction do
      @charge.success = true
      @charge.save!
      find_or_create_customer(current_user).update_subscription(plan: 'docshare-subscription', prorate: true)
    end
    
    if @charge.success
      flash[:notice] = 'Subscription added successfully'
      redirect_to pages_path
    else
      flash[:error] = 'Charge not successful'
      render '/'
    end
    
  rescue Stripe::CardError => errorr
    flash[:error] = errorr.message
    redirect_to pages_path
    false
  end

  def update
    @user = current_user
    @charge = Charge.find(params[:id])

    authorize! :update, @charge, message: 'Not authorized to cancel this subscription'
    
    @user.stripe_account.cancel_subscription(at_period_end: true)
    if @user.stripe_account.subscription[:canceled_at]
      flash[:info] = 'Subscription canceled successfully'
      redirect_to '/pages'
    else
      flash[:error] = 'Error canceling subscription. Please try again.'
      render 'pages/index'
    end
  end

  private
  def find_or_create_customer(user)
    unless user.stripe_account
      user.stripe_id = Stripe::Customer.create(card: params[:stripeToken]).id
      user.save!
    end
    user.stripe_account
  end

end