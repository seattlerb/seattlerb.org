class Post < ActiveRecord::Base
  belongs_to :member

  validates :title,  :presence => true
  validates :body,   :presence => true
  validates :member, :presence => true
end
