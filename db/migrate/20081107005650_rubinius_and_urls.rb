class RubiniusAndUrls < ActiveRecord::Migration
  DUDES = [
            ["Aaron Patterson", "http://tenderlovemaking.com"],
            ["Ara T Howard", "http://codeforpeople.com"],
            ["Assaf Arkin", "http://labnotes.org"],
            ["Chad Fowler", "http://chadfowler.com"],
            ["Dave Thomas", "http://pragdave.pragprog.com"],
            ["Eric Hodel", "http://segment7.net"],
            ["Evan Phoenix", "http://blog.fallingsnow.net"],
            ["Jack Danger Canty", "http://6brand.com"],
            ["Jim Weirich", "http://onestepback.org"],
            ["John Barnette", "http://geeksomnia.com"],
            ["Mike Mondragon", "http://mondragon.cc"],
            ["Phil Hagelberg", "http://technomancy.us"],
            ["Rich Kilmer", "http://richkilmer.blogs.com"],
            ["Ryan Davis", "http://zenspider.com"],
            ["Wilson Bilkovich", "http://metaclass.org"],
          ]

  def self.up
    DUDES.each do |dude|
      Dude.find_by_name(dude.first).update_attributes!(:website => dude.last)
    end
  end

  def self.down
    DUDES.each do |dude|
      Dude.find_by_name(dude.first).update_attributes!(:website => "")
    end
  end
end
