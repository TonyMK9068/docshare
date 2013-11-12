class Page < ActiveRecord::Base

  belongs_to :user

  has_many :collaborators, class_name: "User"
  has_many :viewers, class_name: "User"

  serialize :collaborators, Array
  serialize :viewers, Array

  attr_accessible :body, :public, :title, :user, :collaborators, :viewers
  validates_presence_of :body, :title

  def is_a_collaborator?(user_id)
    collaborator_ids.include? user_id
  end

  def is_a_viewer?(user_id)
    viewer_ids.include? user_id
  end

end