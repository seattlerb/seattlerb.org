class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, :null => false
      t.string :member
      t.belongs_to :group

      t.timestamps
    end
  end
end
