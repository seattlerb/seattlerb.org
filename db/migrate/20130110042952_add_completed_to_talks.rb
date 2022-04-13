class AddCompletedToTalks < ActiveRecord::Migration[4.2]
  def change
    add_column :talks, :completed, :boolean, :default => false
  end
end
