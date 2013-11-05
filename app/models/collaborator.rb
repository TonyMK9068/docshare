class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :page

  attr_accessible :page, :user




end
