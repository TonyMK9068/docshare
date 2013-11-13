class Charge < ActiveRecord::Base
  belongs_to :user
  attr_accessible :customer_id, :success, :user_id
end
