class Project < ActiveRecord::Base
  habtm :dudes, :join_table => :affiliations

  validates_presence_of :name
end
