class Suggestion < ActiveRecord::Base
  validates :title, :presence => true
end
