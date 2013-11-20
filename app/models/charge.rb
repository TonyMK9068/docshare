class Charge < ActiveRecord::Base
  belongs_to :user
  attr_accessible :success
end
