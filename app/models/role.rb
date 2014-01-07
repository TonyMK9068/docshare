class Role < ActiveRecord::Base
  attr_accessible :status
  
  belongs_to :user
  belongs_to :project, class_name: 'Page', foreign_key: :page_id

  validates_uniqueness_of :status, scope: [:page_id, :user_id]
  validates :status, inclusion: %w(collaborator viewer), allow_nil: true

  scope :collaborator, where(status: 'collaborator')
  scope :viewer, where(status: 'viewer')
  
  attr_accessor :project

  def self.status_value(input)
    (input[:collaborator]).present? ? "collaborator" : "viewer"
  end
end

class Array
  def return_users
    each_with_index do |value, index|
      self[index] = User.find_by_id(value[:user_id])
    end
  end
end