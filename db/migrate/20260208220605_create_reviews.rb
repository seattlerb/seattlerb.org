class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :referrable, polymorphic: true
      t.string :field
      t.string :url
      t.string :message

      t.timestamps
      t.index [:referrable_type, :referrable_id]
    end

  end
end
