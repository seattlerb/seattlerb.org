class CreateGauntletProject < ActiveRecord::Migration
  def self.up
    Project.create!(:name        => "Gauntlet",
                    :url         => "http://rubyforge.org/projects/seattlerb",
                    :description => "Gauntlet is a pluggable means of running code against all the latest gems and storing off the data.")
    Affiliation.create!(:dude => Dude.find_by_name("Ryan Davis"), :project => Project.find_by_name("Gauntlet"))
  end

  def self.down
    Affiliation.find_by_dude_id_and_project_id(Dude.find_by_name("Ryan Davis"), Project.find_by_name("Gauntlet"))
    Project.find_by_name("Gauntlet").destroy
  end
end
