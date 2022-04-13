class AddEmailToTalks < ActiveRecord::Migration[4.2]
  def change
    add_column :talks, :email, :string, :null => false, :default => ""
  end
end
