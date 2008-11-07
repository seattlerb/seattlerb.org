class RubiniusToEvanRyanEric < ActiveRecord::Migration
  def self.up
    Project.create!(:name        => "Rubinius",
                    :url         => "http://rubini.us",
                    :description => "A virtual machine for running Ruby programs and a Ruby core library.")
    ["Evan Phoenix", "Ryan Davis", "Eric Hodel"].each do |dude|
      Affiliation.create!(:dude => Dude.find_by_name(dude), :project => Project.find_by_name("Rubinius"))
    end
  end

  def self.down
    Project.find_by_name("Rubinius").destroy
  end
end
