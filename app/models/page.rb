class Page < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :viewers, dependent: :destroy
  attr_accessible :body, :public, :title, :user, :collaborators, :viewers
  validates_presence_of :body, :title

end