class Suggestion < ApplicationRecord
  validates :title, :presence => true
  attr_accessor :comment # fake attribute for spam trapping
  validates_length_of :comment, :in => 0..1
end
