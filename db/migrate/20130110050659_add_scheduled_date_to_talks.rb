class AddScheduledDateToTalks < ActiveRecord::Migration[4.2]
  def change
    add_column :talks, :scheduled_date, :date
  end
end
