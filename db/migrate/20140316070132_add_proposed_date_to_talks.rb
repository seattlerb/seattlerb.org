class AddProposedDateToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :proposed_date, :date
  end
end
