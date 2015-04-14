class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :book, :null => false
      t.boolean :active, :default => true
      t.string :github
    end
  end
end
