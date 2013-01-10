class AddCompletedToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :completed, :boolean
  end
end
