class Page < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_paper_trail :only => [:body => Proc.new { |obj| !obj.body.blank? } ], :on => [:update, :destroy]
                  
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates_presence_of :body, :title, :slug
  validates_uniqueness_of :slug
  
  attr_accessible :body, :public, :title, :user, :role, :slug

  #returns array of Role instances belonging to page for status value supplied in parameter
  def page_role_instances(association)
    page, roles = self, []
    roles = lambda { |state| Role.joins(:user).where(:status => state, :page_id => page.id) }.call(association)
  end

  #returns an array of User instances belonging to page through provided role
  def user_instances(association)
    page, roles = self, []
    roles = self.page_role_instances(association).collect do |instance|
      User.find_by_id(instance.user_id)
    end    
  end

  # creates a role instance given a user instance as argument with status defined as owner
  # used in page controller to set owner attribute for user creating a new page
  def create_role(user)
    role = Role.create(:page_id => self.id, :user_id => user.id, :status => 'owner')
  end

  def number_of_versions
    self.versions.count
  end

end