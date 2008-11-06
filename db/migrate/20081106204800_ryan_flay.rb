class RyanFlay < ActiveRecord::Migration
  def self.up
    project = Project.create!(:name        => "flay",
                              :url         => "http://rubyforge.org/projects/seattlerb",
                              :description => "Flay analyzes ruby code for structural similarities. Differences in literal values, variable, class, method names, whitespace, programming style, braces vs do/end, etc are all ignored. Making this totally rad.")
    Affiliation.create!(:dude => Dude.find_by_name("Ryan Davis"), :project => project)
  end

  def self.down
    Project.find_by_name("flay").destroy
    Affiliation.find_by_dude_id_and_project_id(Dude.find_by_name("Ryan Davis"), Project.find_by_name("flay")).destroy
  end
end
