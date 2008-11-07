class RubygemsUpdateToRubygems < ActiveRecord::Migration
  def self.up
    Project.find_by_name("rubygems-update").update_attributes(
      :name => "rubygems", 
      :url => "http://rubygems.org",
      :description => "RubyGems is a sophisticated package manager for Ruby."
    )
  end

  def self.down
    raise IrreversibleMigration
  end
end
