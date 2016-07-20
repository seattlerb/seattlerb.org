class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :member_id, :null => false
      t.string :title, :null => false
      t.string :author, :null => false
      t.text :comment
    end
  end
end
