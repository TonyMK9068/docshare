class Role < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  attr_accessible :status, :page_id, :user_id
  validates_uniqueness_of :status, scope: [:page_id, :user_id]
  validates :status, inclusion: { in: %w(owner contributor viewer),
    message: "Invalid role" }
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

