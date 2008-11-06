class PoopulateDudes < ActiveRecord::Migration
  def self.up
    ["Aaron Patterson",
    "Ara T Howard",
    "Assaf Arkin",
    "Bob Cottrell",
    "Chad Fowler",
    "Damon Danieli",
    "Dave Myron",
    "Dave Thomas",
    "Eric Hodel",
    "Eric Wong",
    "Evan Phoenix",
    "Jack Danger Canty",
    "Jim Weirich",
    "John Barnette",
    "Kouhei Sutou",
    "Mike Mondragon",
    "Phil Hagelberg",
    "Rich Kilmer",
    "Robert Cottrell",
    "Ryan Davis",
    "Tony Strauss",
    "Wilson Bilkovich"].each do |dude|
      Dude.create!(:name => dude)
    end
  end

  def self.down
    Dude.all.each do |dude|
      dude.destroy
    end
  end
end
