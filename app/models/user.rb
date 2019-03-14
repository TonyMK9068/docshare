class User < ActiveRecord::Base
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:site_admin, :collaborator, :owner], multiple: false)                                      ##
  ############################################################################################

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :trackable

  has_many :pages, dependent: :destroy
  has_many :roles
  has_many :projects, through: :roles
  has_many :charges
  
  validates_presence_of :email
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