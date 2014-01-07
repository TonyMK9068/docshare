class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :body, :public, :title, :slug

  has_paper_trail only: [ body: Proc.new { |obj| !obj.body.blank? } ], on: [:update, :destroy]

  belongs_to :user
  has_many :roles, inverse_of: :project
  
  validates_presence_of :slug
  validates :title, length: { minimum:6 }, presence: true
  validates :body, length: { minimum:15 }, presence: true

  def viewers_assigned?
    viewers.count > 0
  end
  
  def collaborators_assigned?
    collaborators.count > 0
  end

  def number_of_versions
    versions.index.count
  end

  def is_public?
    public
  end

  def is_private?
    not public
  end

  def collaborators
    roles.collaborator.collect { |role| role.user }
  end
  
  def viewers
    roles.viewer.collect { |role| role.user }
  end
end