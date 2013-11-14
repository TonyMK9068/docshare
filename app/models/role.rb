class Role < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  attr_accessible :status, :user_id, :page_id
  validates_uniqueness_of :status, scope: [:page_id, :user_id]
end
