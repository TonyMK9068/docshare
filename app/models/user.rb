class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, dependent: :destroy
  has_many :pages,  through: :roles
  has_many :charges

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username, :subscriber, :role, :charge
  # attr_accessible :title, :body
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

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

  #return an array of Role instances for a user. Parameter is one of the three status string values.
  def user_role_instances(association)
    user, roles = self, []
    roles = lambda { |state| Role.joins(:page).where(:status => state, :user_id => user.id) }.call(association)
  end

  #return Page instances that user is belongs to via role supplied in argument
  def user_page_instances(association)
    user, roles = self, []
    roles = user.user_role_instances(association).collect do |instance|
      Page.find_by_id(instance.page_id)
    end
  end

  def display_role(page)
    role = Role.where(:user_id => self.id, :page_id => page.id).first.status
  end
end