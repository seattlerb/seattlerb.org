class Project < ActiveRecord::Base
  habtm :members, :join_table => :affiliations

  validates_presence_of :name
end
