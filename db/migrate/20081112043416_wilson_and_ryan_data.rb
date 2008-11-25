class WilsonAndRyanData < ActiveRecord::Migration
  def self.up
    Dude.find_by_name("Ryan Davis").update_attributes!(:email => "ryand-ruby@zenspider.com")
    Dude.find_by_name("Wilson Bilkovich").update_attributes!(:bio => "Honorary Member")
  end

  def self.down
    Dude.find_by_name("Ryan Davis").update_attributes!(:email => "")
    Dude.find_by_name("Wilson Bilkovich").update_attributes!(:bio => "")
  end
end
