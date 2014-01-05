class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username, :subscriber

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :rememberable, :trackable, :secure_validatable, :session_limitable

  has_many :roles, dependent: :destroy
  has_many :pages,  through: :roles
  has_many :charges
  
  validates :email, :email => true
  validates :username, length: { minimum: 6 }, presence: true, uniqueness: true
  validates_format_of :username, with: /\A^[a-zA-Z0-9-]+\z/

  # on authentication, subscriber status is checked
  Warden::Manager.after_authentication do |user,auth,opts|
    if user.charges.length > 0
      id = user.charges.last.customer_id
      customer = Stripe::Customer.retrieve(id)
      if customer.subscription[:status] == "active"
        user.update_attribute(:subscriber, true)
      else
        user.update_attribute(:subscriber, false)
      end
    end
  end
  
  # take these lambdas out
  def lambda_page
    l = lambda { |state, user| Role.joins(:page).where(:status => state, :user_id => user.id) }
  end

  #returns array of Role instances for page with owner status
  def owners
    lambda_page.call('owner', self)
  end

  #returns array of Role instances for page with collaborator status
  def collaborators
    lambda_page.call('collaborator', self)
  end

  #returns array of Role instances for page with viewer status
  def viewers
    lambda_page.call('viewer', self)
  end
end