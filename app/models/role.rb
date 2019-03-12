class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :project, class_name: 'Page', foreign_key: :page_id

  validates :status, inclusion: %w(collaborator viewer), allow_nil: true

  scope :collaborator, where(status: 'collaborator')
  scope :viewer, where(status: 'viewer')

end