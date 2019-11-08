class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :book, :null => false
      t.boolean :active, :default => true, :null => false
      t.string :github
    end
  end
end
