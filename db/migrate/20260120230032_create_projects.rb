class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.text :description

      t.integer :affiliations_count, default: 0, null: false

      t.timestamps
    end
  end
end
