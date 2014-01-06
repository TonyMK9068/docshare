class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :subscriber

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :rememberable, :trackable, :secure_validatable, :session_limitable

  has_many :roles, dependent: :destroy
  has_many :pages,  through: :roles
  has_many :charges
  
  validates :email, :email => true
  validates :username, length: { minimum: 6 }, presence: true, uniqueness: true
  validates_format_of :username, with: /\A^[a-zA-Z0-9-]+\z/
  
  def has_charges?
    self.charges.count > 0
  end
  
  def self.with_attribute_value(name)
    User.find_by_email(name) || User.find_by_username(name)
  end
  
  def self.find_user(input)
    User.with_attribute_value(input).presence
  end

  def pages_owned
    Role.owners.joins(:page).where(user_id: self.id).all.collect do |role|
      Page.find role.page_id
    end
  end
  
  def pages_collaborating_on
    Role.collaborators.joins(:page).where(user_id: self.id).all.collect do |role|
      Page.find role.page_id
    end
  end
  
  def pages_viewable
    Role.viewers.joins(:page).where(user_id: self.id).all.collect do |role|
      Page.find role.page_id
    end
  end

  # todo: check for method for find(version.originator.to_i).username

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