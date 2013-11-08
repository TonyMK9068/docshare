class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pages
  has_many :collaborators
  has_many :viewers


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :username, :subscriber, :collaborator, :viewer
  # attr_accessible :title, :body
validates_presence_of :username
validates_uniqueness_of :username
  
 def update_user_subscribed
  self.update_attribute(:subscriber, true)
 end

def can_collaborate_on?(page_id)
  collaborator_ids.include? page_id
end

def can_view?(page_id)
  viewer_ids.include? page_id
end

end
