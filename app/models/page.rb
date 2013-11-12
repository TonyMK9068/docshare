class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  has_many :collaborators
  has_many :viewers

  attr_accessible :body, :public, :title, :user, :collaborators, :viewers
  validates_presence_of :body, :title, :slug
  validates_uniqueness_of :slug

  def is_a_collaborator?(user_id)
    collaborator_ids.include? user_id
  end

  def is_a_viewer?(user_id)
    viewer_ids.include? user_id
  end

end