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
  
  def pages_with_role(status)
    self.pages.all.collect { |page| Role.joins(:user).where(status: status, page_id: page.id) }
  end

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
end