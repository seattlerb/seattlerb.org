class Comment < ActiveRecord::Base
	belongs_to :group
	validates_presence_of :group_id, :body

	attr_accessor :username # fake attribute for spam trapping
  validates_length_of :username, :maximum => 0

end
