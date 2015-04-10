class AddCompletedToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :completed, :boolean, :default => false
  end
end
