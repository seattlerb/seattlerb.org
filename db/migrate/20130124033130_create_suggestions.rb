class CreateSuggestions < ActiveRecord::Migration[4.2]
  def change
    create_table :suggestions do |t|
      t.string :title

      t.timestamps
    end
  end
end
