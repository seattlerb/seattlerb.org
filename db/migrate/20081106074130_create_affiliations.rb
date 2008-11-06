class CreateAffiliations < ActiveRecord::Migration
  def self.up
    create_table :affiliations do |t|
      t.belongs_to :dude, :project

      t.timestamps
    end
  end

  def self.down
    drop_table :affiliations
  end
end
