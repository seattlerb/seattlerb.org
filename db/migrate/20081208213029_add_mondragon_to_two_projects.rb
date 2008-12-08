class AddMondragonToTwoProjects < ActiveRecord::Migration
  def self.up
    Affiliation.create!(:dude => Dude.find_by_name("Mike Mondgragon"), :project => Project.find_by_name("blackbook"))
    Affiliation.create!(:dude => Dude.find_by_name("Mike Mondgragon"), :project => Project.find_by_name("is_it_mobile"))
  end

  def self.down
    Affiliation.find_by_dude_id_and_project_id(Dude.find_by_name("Mike Mondgragon"), Project.find_by_name("blackbook"))
    Affiliation.find_by_dude_id_and_project_id(Dude.find_by_name("Mike Mondgragon"), Project.find_by_name("is_it_mobile"))
  end
end
