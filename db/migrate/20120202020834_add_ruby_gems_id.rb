class AddRubyGemsId < ActiveRecord::Migration
  def up
    Dude.find_by_name("Aaron Patterson").update_attributes!(:ruby_gems_id => "aaronp")
    Dude.find_by_name("Alex Vollmer").update_attributes!(:ruby_gems_id => "avollmer")
    Dude.find_by_name("Andy Smith").update_attributes!(:ruby_gems_id => "aasmith")
    Dude.find_by_name("Damon Danieli").update_attributes!(:ruby_gems_id => "damondanieli")
    Dude.find_by_name("Dave Myron").update_attributes!(:ruby_gems_id => "orangechicken")
    Dude.find_by_name("Eric Hodel").update_attributes!(:ruby_gems_id => "drbrain")
    Dude.find_by_name("Eric Wong").update_attributes!(:ruby_gems_id => "normalperson")
    Dude.find_by_name("Evan Phoenix").update_attributes!(:ruby_gems_id => "evan")
    Dude.find_by_name("Geoffrey Grosenbach").update_attributes!(:ruby_gems_id => "topfunky")
    Dude.find_by_name("Jack Danger Canty").update_attributes!(:ruby_gems_id => "jackdanger")
    Dude.find_by_name("John Barnette").update_attributes!(:ruby_gems_id => "jbarnette")
    Dude.find_by_name("Mike Mondragon").update_attributes!(:ruby_gems_id => "mikemondragon")
    Dude.find_by_name("Phil Hagelberg").update_attributes!(:ruby_gems_id => "technomancy")
    Dude.find_by_name("Ryan Davis").update_attributes!(:ruby_gems_id => "zenspider")
    Dude.find_by_name("Wilson Bilkovich").update_attributes!(:ruby_gems_id => "wilson")
  end

  def down
    Dude.find_by_name("Aaron Patterson").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Alex Vollmer").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Andy Smith").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Damon Danieli").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Dave Myron").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Eric Hodel").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Eric Wong").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Evan Phoenix").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Geoffrey Grosenbach").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Jack Danger Canty").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("John Barnette").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Mike Mondragon").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Phil Hagelberg").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Ryan Davis").update_attributes!(:ruby_gems_id => "")
    Dude.find_by_name("Wilson Bilkovich").update_attributes!(:ruby_gems_id => "")
  end
end
