class AddEmailToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :email, :string, :null => false, :default => ""
  end
end
