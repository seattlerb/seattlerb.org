class CreateTalks < ActiveRecord::Migration[4.2]
  def up
    create_table :talks do |t|
      t.string :title
      t.text :description
      t.string :presenter
      t.string :kind
    end
  end

  def down
    drop_table :talks
  end
end
