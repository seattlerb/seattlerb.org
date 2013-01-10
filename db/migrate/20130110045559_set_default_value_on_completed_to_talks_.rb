class SetDefaultValueOnCompletedToTalks_ < ActiveRecord::Migration
  def change
    change_column :talks, :completed, :boolean, :default => false
  end
end
