class ApplicationController < ActionController::Base

  protect_from_forgery

#  def new_plan 
#    plan = Stripe::Plan.create(
#   :amount => @amount,
#   :currency => 'usd',
#   :interval => 'month',
#   :id => 'basic',
#   :name => 'Docshare subscription'
#   )
# end

  def after_sign_in_path_for(resource)
    pages_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
