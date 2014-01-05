class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :body, :public, :title, :user_id, :slug

  has_paper_trail only: [ body: Proc.new { |obj| !obj.body.blank? } ], on: [:update, :destroy]

  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_many :roles
  
  validates_presence_of :slug
  validates :title, length: { minimum:6 }, presence: true
  validates :body, length: { minimum:15 }, presence: true
  
  after_create :set_owner

  def viewers_assigned?
    self.viewers.count > 0
  end
  
  def collaborators_assigned?
    self.collaborators.count > 0
  end

  def number_of_versions
    self.versions.index.count
  end

  def is_public?
    self.public
  end

  def is_private?
    !self.public
  end
  
  def owned_by
    Role.owners.joins(:user).where(page_id: self.id).all.collect do |role|
      User.find role.user_id
    end
  end
  
  def collaborators
    Role.collaborators.joins(:user).where(page_id: self.id).all.collect do |role|
      User.find role.user_id
    end
  end
  
  def viewers
    Role.viewers.joins(:user).where(page_id: self.id).all.collect do |role|
      User.find role.user_id
    end
  end

  protected

  def set_owner
    role = self.roles.build(user_id: self.user_id, status: 'owner')
    role.save
  end

end