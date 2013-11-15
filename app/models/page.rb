class Page < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :body, :public, :title, :user, :role, :slug

  friendly_id :title, :use => :slugged
  has_paper_trail :only => [:body => Proc.new { |obj| !obj.body.blank? } ], :on => [:update, :destroy]
                  
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  def lambda_user
    l = lambda { |state, page| Role.joins(:user).where(:status => state, :page_id => page.id) }
  end

  #returns array of Role instances for page with owner status
  def owners
    lambda_user.call('owner', self)
  end

  #returns array of Role instances for page with collaborator status
  def collaborators
    lambda_user.call('collaborator', self)
  end

  #returns array of Role instances for page with viewer status
  def viewers
    lambda_user.call('viewer', self)
  end

  # creates an owner role for the user provided in by the parameter
  # used in page controller to set owner attribute for user creating a new page
  def set_owner(user)
    role = Role.create(:page_id => self.id, :user_id => user.id, :status => 'owner')
  end

  def number_of_versions
    self.versions.index.count
  end

  private

  validates_presence_of :slug
  validates :title, length: { minimum:6 }, presence: true
  validates :body, length: { minimum:15 }, presence: true
end