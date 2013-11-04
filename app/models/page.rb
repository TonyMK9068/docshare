class Page < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :public, :title, :user, :collaborators, :viewers
validates_presence_of :body, :title



serialize(:collaborators, Array)

end
