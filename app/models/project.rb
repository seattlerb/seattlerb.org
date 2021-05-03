class Project < ApplicationRecord
  habtm :members, :join_table => :affiliations

  validates_presence_of :name
end
