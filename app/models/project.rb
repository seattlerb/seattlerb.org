class Project < ActiveRecord::Base
  validates_presence_of :name
  has_many :affiliations
  has_many :dudes, :through => :affiliations
end
