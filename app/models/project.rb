class Project < ActiveRecord::Base
  has_many :dudes, through: :affiliations
  has_many :affiliations

  validates_presence_of :name
end
