class Project < ActiveRecord::Base
  validates_presence_of :name
  has_many :affiliations, :dependent => :destroy
  has_many :dudes, :through => :affiliations
end
