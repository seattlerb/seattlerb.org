class Book < ActiveRecord::Base
  belongs_to :member

  validates :title, :presence => true
  validates :author, :presence => true

  attr_accessor :username # fake attribute for spam trapping
  validates_length_of :username, :maximum => 0

end
