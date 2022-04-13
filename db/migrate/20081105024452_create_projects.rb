class CreateProjects < ActiveRecord::Migration[4.2]
  def self.up
    create_table :projects do |t|
      t.string :name, :url
      t.text   :description

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
