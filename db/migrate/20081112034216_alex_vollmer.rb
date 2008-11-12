class AlexVollmer < ActiveRecord::Migration
  def self.up
    pci4r = Project.create!(
              :name => "pci4r",
              :description => "Ruby port of Programming Collective Intelligence",
              :url => "http://github.com/alexvollmer/pci4r"
            )

    alex = Dude.find_by_name("Alex Vollmer").update_attributes!(
              :website => "http://livollmers.net",
              :email   => "alex.vollmer@gmail.com",
              :bio     => "Alex is a frustrated heavy-metal guitarist who once beat Jack Butler in a duel with a Toys-R-Us guitar and a popsicle stick for a pick. But since rad metal guitarists are currently out of fashion, he moonlights as a computer geek until that day when metal returns to take its rightful place."
            )

    Affiliation.create!(:dude => Dude.find_by_name("Alex Vollmer"), :project => Project.find_by_name("pci4r"))
  end

  def self.down
    Affiliation.find_by_project_id(Project.find_by_name("pci4r")).destroy
    Project.find_by_name("pci4r").destroy
    Dude.find_by_name("Alex Vollmer").update_attributes!(:website => "", :email => "", :bio => "")
  end
end
