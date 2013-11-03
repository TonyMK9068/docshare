class Page < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :public, :title, :user


end
