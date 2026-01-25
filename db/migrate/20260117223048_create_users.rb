class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email_address
      t.string :password_digest, null: false, default: "*"
      t.boolean :verified,       null: false, default: false
      t.boolean :admin,          null: false, default: false

      t.text   :bio
      t.string :website
      t.string :rubygems_name
      t.string :github_name

      t.integer :affiliations_count, default: 0, null: false

      t.timestamps
    end
    add_index :users, :email_address
  end
end
