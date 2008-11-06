class CreateDudes < ActiveRecord::Migration
  def self.up
    create_table :dudes do |t|
      t.string :name, :email, :bio, :website

      t.timestamps
    end
  end

  def self.down
    drop_table :dudes
  end
end
