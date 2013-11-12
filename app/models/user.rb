class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pages
  has_many :can_collaborate,  class_name: "Page", foreign_key: "collaborator_id"
  has_many :can_view, class_name: "Page", foreign_key: "viewer_id"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :can_collaborate, :can_view,
                  :remember_me, :username, :subscriber, :collaborator, :viewer
  # attr_accessible :title, :body
validates_presence_of :username
validates_uniqueness_of :username
  
 def update_user_subscribed
  self.update_attribute(:subscriber, true)
 end

end
