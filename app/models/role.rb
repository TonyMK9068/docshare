class Role < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  attr_accessible :status, :user_id, :page_id


end
