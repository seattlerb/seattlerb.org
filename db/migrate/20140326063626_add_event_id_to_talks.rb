class AddEventIdToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :event_id, :integer
  end
end
