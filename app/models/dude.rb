class Dude < ActiveRecord::Base
  validates_presence_of :name
  has_many :affiliations
  has_many :projects, :through => :affiliations
end
