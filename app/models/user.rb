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
  
  scope :subscribers, lambda { where(subscriber: true) }
  
  def has_charges?
    charges.count > 0
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
  
  def stripe_account
    begin
      Stripe::Customer.retrieve(stripe_id)
      rescue
      Stripe::InvalidRequestError
      return false
    end
  end

end