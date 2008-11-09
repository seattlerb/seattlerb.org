class AddUnAndPhilsData < ActiveRecord::Migration
  def self.up
    Dude.find_by_name("Damon Danieli").update_attributes!(
      :website => "http://damondanieli.blogspot.com", 
      :bio => "Just started a company with Madrona Venture Group"
    )
    
    Dude.find_by_name("Jack Danger Canty").update_attributes!(
      :bio => "I've had enough of the 'ruby rockstar' and 'code ninja' buzzwords. Lame. I think we should start calling ourselves 'Web Godzillas' until somebody finally gets the joke that we just sit and type all day."
    )
    
    Dude.find_by_name("Phil Hagelberg").update_attributes!(
      :email => "phil@hagelb.org",
      :bio   => "A dynamic language hacker who occasionally makes outlandish claims to be the greatest sword-fighter in the world. He writes a lot of Lisp."
    )
    
    Affiliation.create!(:project => Project.find_by_name("clip"), :dude => Dude.find_by_name("Phil Hagelberg"))
    
    Project.find_by_name("Watcher in the Water").update_attributes!(:url => "http://github.com/technomancy/watcher_in_the_water")
    
    Project.create!(
      :name        => "un",
      :url         => "http://rubyforge.org/projects/seattlerb", 
      :description => "un provides unextend and uninclude to allow for a better prototype-oriented programming experience."
    )
    
    Affiliation.create!(:project => Project.find_by_name("un"), :dude => Dude.find_by_name("Ryan Davis"))
  end

  def self.down
    Dude.find_by_name("Damon Danieli").update_attributes!(:website => "", :bio => "")
    Dude.find_by_name("Jack Danger Canty").update_attributes!(:bio => "")
    Dude.find_by_name("Phil Hagelberg").update_attributes!(:email => "", :bio => "")
    Affiliation.find_by_dude_id_and_project_id(
      Dude.find_by_name("Phil Hagelberg"), Project.find_by_name("clip")
    )
    Affiliation.find_by_dude_id_and_project_id(
      Dude.find_by_name("Ryan Davis"), Project.find_by_name("un")
    )
    Project.find_by_name("Watcher in the Water").update_attributes!(:url => "")
  end
end
