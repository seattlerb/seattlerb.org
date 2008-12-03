class AddEmails < ActiveRecord::Migration
  def self.up
    Dude.find_by_name("Eric Hodel").update_attributes!(:email => "drbrain@segment7.net")
    Dude.find_by_name("Geoffrey Grosenbach").update_attributes!(:email => "boss@topfunky.com")
    Dude.find_by_name("Aaron Patterson").update_attributes!(:email => "aaron.patterson@gmail.com")
    Dude.find_by_name("Evan Phoenix").update_attributes!(:email => "evan@fallingsnow.net")
    Dude.find_by_name("John Barnette").update_attributes!(:email => "jbarnette@gmail.com")
    Dude.find_by_name("Mike Mondragon").update_attributes!(:email => "mikemondragon@gmail.com")
    Dude.find_by_name("Andy Smith").update_attributes!(:email => "andy@tinnedfruit.org")

    Affiliation.create!(
      :dude => Dude.find_by_name("Wilson Bilkovich"),
      :project => Project.find_by_name("Rubinius")
    )
  end

  def self.down
    Dude.find_by_name("Eric Hodel").update_attributes!(:email => "")
    Dude.find_by_name("Geoffrey Grosenbach").update_attributes!(:email => "")
    Dude.find_by_name("Aaron Patterson").update_attributes!(:email => "")
    Dude.find_by_name("Evan Phoenix").update_attributes!(:email => "")
    Dude.find_by_name("John Barnette").update_attributes!(:email => "")
    Dude.find_by_name("Mike Mondragon").update_attributes!(:email => "")
    Dude.find_by_name("Andy Smith").update_attributes!(:email => "")

    Affiliation.find_by_dude_id_and_project_id(
      :dude    => Dude.find_by_name("Wilson Bilkovich"),
      :project => Project.find_by_name("Rubinius")
    ).destroy
  end
end
