class Affiliation < ActiveRecord::Base
  belongs_to :dude
  belongs_to :project
end
