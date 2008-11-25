class RemoveDoublePhil < ActiveRecord::Migration
  def self.up
    Affiliation.find_all_by_project_id_and_dude_id(
      Dude.find_by_name("Phil Hagelberg").id,
      Project.find_by_name("clip").id
    )
  end

  def self.down
  end
end
