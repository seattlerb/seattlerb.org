class Post < ActiveRecord::Base
  belongs_to :member
  attr_accessible :body, :published, :title
  attr_accessor :member

  validates :title,  :presence => true
  validates :body,   :presence => true
  validates :member, :presence => true
end
