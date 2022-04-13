class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.date :date

      t.timestamps
    end
  end
end
