class AddEventIdToTalks < ActiveRecord::Migration[4.2]
  def change
    add_column :talks, :event_id, :integer
  end
end
