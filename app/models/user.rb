class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username, :subscriber, :charge

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, dependent: :destroy
  has_many :pages,  through: :roles
  has_many :charges

  # Setup accessible (or protected) attributes for your model

  # attr_accessible :title, :body

  #upon authentication, subscriber status is checked
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

#  def display_role(page)
#    role = Role.where(:user_id => self.id, :page_id => page.id).first.status
# end
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

  validates :username, length: { minimum:6 }, presence: true, uniqueness: true
  validates_presence_of :email
  validates_uniqueness_of :email

end