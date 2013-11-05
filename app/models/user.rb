class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
    
has_many :pages, dependent: :destroy
has_many :viewers, dependent: :destroy
has_many :collaborators, dependent: :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :username, :subscriber
  # attr_accessible :title, :body
validates_presence_of :username
validates_uniqueness_of :username
  
 def update_user_subscribed
  self.update_attribute(:subscriber, true)
 end


end
