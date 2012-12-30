class Project < ActiveRecord::Base
  habtm :dudes, :table_name => :affiliations

  validates_presence_of :name
end
