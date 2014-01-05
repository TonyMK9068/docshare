class Role < ActiveRecord::Base
  attr_accessible :status, :page_id, :user_id
  
  belongs_to :page
  belongs_to :user

  validates_uniqueness_of :status, scope: [:page_id, :user_id]
  validates :status, inclusion: %w(owner collaborator viewer), allow_nil: true
  
  scope :owners, where(status: 'owner')
  scope :collaborators, where(status: 'collaborator')
  scope :viewers, where(status: 'viewer')
end

class Array
  def return_users
    self.each_with_index do |value, index|
      self[index] = User.find_by_id(value[:user_id])
    end
  end

  def return_pages
    self.each_with_index do |value, index|
      self[index] = Page.find_by_id(value[:page_id])
    end
  end

end

