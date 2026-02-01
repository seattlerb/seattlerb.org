class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.string :klass
      t.integer :ref_id
      t.string :field
      t.string :url
      t.string :message

      t.timestamps
    end
  end
end
