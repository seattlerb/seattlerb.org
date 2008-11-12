class AlexVollmer < ActiveRecord::Migration
  def self.up
    Project.create!(
      :name => "pci4r",
      :description => "Ruby port of Programming Collective Intelligence",
      :url => "http://github.com/alexvollmer/pci4r"
    )

    Dude.find_by_name("Alex Vollmer").update_attributes!(
      :website => "http://livollmers.net",
      :email   => "alex.vollmer@gmail.com"
    )

    Affiliation.create!(:dude => Dude.find_by_name("Alex Vollmer"), :project => Project.find_by_name("pci4r"))
  end

  def self.down
    Affiliation.find_by_project_id(Project.find_by_name("pci4r")).destroy
    Project.find_by_name("pci4r").destroy
    Dude.find_by_name("Alex Vollmer").update_attributes!(:website => "", :email => "", :bio => "")
  end
end
