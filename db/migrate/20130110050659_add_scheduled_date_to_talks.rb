class AddScheduledDateToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :scheduled_date, :date
  end
end
