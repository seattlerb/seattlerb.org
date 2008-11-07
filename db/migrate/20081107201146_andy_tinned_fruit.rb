class AndyTinnedFruit < ActiveRecord::Migration
  def self.up
    Dude.find_by_name("Andy Smith").update_attributes!(:website => "http://tinnedfruit.org")
  end

  def self.down
    Dude.find_by_name("Andy Smith").update_attributes!(:website => "")
  end
end
