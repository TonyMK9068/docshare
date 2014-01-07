class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username, :subscriber

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :trackable, :secure_validatable, :session_limitable

  has_many :pages, dependent: :destroy
  has_many :roles
  has_many :projects, through: :roles
  has_many :charges
  
  validates :email, :email => true
  validates :username, length: { minimum: 6 }, presence: true, uniqueness: true
  validates_format_of :username, with: /\A([a-zA-Z]+[a-zA-Z0-9]*(?:[-_]?[a-zA-Z0-9]+)?)\z/
  
  def has_charges?
    charges.count > 0
  end
  
  def self.with_attribute_value(name)
    find_by_email(name) || find_by_username(name)
  end
  
  def self.find_user(input)
    with_attribute_value(input).presence
  end

  def pages_owned
    pages.all
  end
  
  def collaborations
    roles.collaborator.collect { |role| Page.find role.page_id }
  end
  
  def private_projects_shared
    roles.viewer.collect { |role| Page.find role.page_id }
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