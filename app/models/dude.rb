class Dude < ActiveRecord::Base
  validates_presence_of :name
  has_many :affiliations, :dependent => :destroy
  has_many :projects, :through => :affiliations
end
