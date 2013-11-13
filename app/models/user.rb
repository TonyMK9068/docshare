class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, dependent: :destroy
  has_many :pages,  through: :roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username, :subscriber, :role
  # attr_accessible :title, :body
  validates_presence_of :username
  validates_uniqueness_of :username
  
  def update_user_subscribed
    self.update_attribute(:subscriber, true)
  end

  def pages_owned
    roles =[]
    roles = Role.joins(:page).where(:status => 'owner', :user_id => self.id)
    roles.collect do |instance|
      Page.find_by_id(instance.page_id)
    end
  end

  def pages_can_collaborate
    roles =[]
    roles = Role.joins(:page).where(:status => 'collaborator', :user_id => self.id)
    roles.collect do |instance|
      Page.find_by_id(instance.page_id)
    end
  end

  def pages_can_view
    roles =[]
    roles = Role.joins(:page).where(:status => 'viewer', :user_id => self.id)
    roles.collect do |instance|
      Page.find_by_id(instance.page_id)
    end
  end

  def display_role(page)
    role = Role.where(:user_id => self.id, :page_id => page.id).first.status
  end


end