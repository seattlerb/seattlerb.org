class AddCompletedToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :completed, :boolean, :default => false

    Talk.all.each do |t|
      t.completed = false
      t.save
    end
  end
end
