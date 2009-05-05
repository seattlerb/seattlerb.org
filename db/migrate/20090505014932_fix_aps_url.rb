class FixApsUrl < ActiveRecord::Migration
  def self.up
    Project.find_by_name("mechanize").update_attributes!(:url => "http://rubyforge.org/projects/mechanize")
  end

  def self.down
    Project.find_by_name("mechanize").update_attributes!(:url => "http://rubyforge.org/projects/logmerge")
  end
end
