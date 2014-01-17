class Subscription < ActiveRecord::Base
  belongs_to :user
  # attr_accessible :title, :body
  # want subsctiption instance to have:
    cost...etc
  
end
