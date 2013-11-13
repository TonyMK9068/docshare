class Page < ActiveRecord::Base

  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  attr_accessible :body, :public, :title, :user, :role
  validates_presence_of :body, :title

  def list_of_viewers
    roles =[]
    roles = Role.joins(:user).where(:status => 'viewer', :page_id => self.id)
    roles.collect do |instance|
      User.find_by_id(instance.user_id)
    end    
  end

  def list_of_collaborators
    roles =[]
    roles = Role.joins(:user).where(:status => 'collaborator', :page_id => self.id)
    roles.collect do |instance|
      User.find_by_id(instance.user_id)
    end    
  end

  

  def create_role(user)
    role = Role.create(:page_id => self.id, :user_id => user.id, :status => 'owner')
  end

end