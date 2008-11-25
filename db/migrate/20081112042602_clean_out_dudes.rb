class CleanOutDudes < ActiveRecord::Migration
  def self.up
    ["Kouhei Sutou",
    "Robert Cottrell",
    "Bob Cottrell",
    "Chad Fowler",
    "Ara T Howard",
    "Assaf Arkin",
    "Dave Thomas",
    "Tony Strauss",
    "Jim Weirich",
    "Rich Kilmer"].each do |dude|
      Dude.find_by_name(dude).destroy
    end
    
    Project.find_by_name("uuid").destroy
    
    Project.all.each do |project|
      if project.dudes.length.zero?
        project.destroy
      end
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
