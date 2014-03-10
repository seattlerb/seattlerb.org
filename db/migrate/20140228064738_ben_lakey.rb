class BenLakey < ActiveRecord::Migration
  def up
    ben = Dude.create!(:name => "Ben Lakey", :website => "http://benlakey.com", :twitter => "benlakey", :github => "benlakey", :image_url => "http://www.gravatar.com/avatar/7fc08a3fdbc3e903bd25960e2a00e35a", :ruby_gems_id => "benlakey")
  end

  def down
    Dude.find_by_name("Ben Lakey").destroy
  end
end
