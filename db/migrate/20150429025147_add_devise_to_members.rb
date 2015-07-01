class AddDeviseToMembers < ActiveRecord::Migration
  def self.up
    Member.where(:email => nil).update_all(:email => "")

    change_column_null(:members, :email, false, "" )

    change_table(:members) do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :members, :email
    add_index :members, :reset_password_token, unique: true
    # add_index :members, :confirmation_token,   unique: true
    # add_index :members, :unlock_token,         unique: true
  end

  def self.down
    change_column_null(:users, :email, true)

    remove_column :members, :encrypted_password
    remove_column :members, :reset_password_token
    remove_column :members, :reset_password_sent_at
    remove_column :members, :remember_created_at
    remove_column :members, :sign_in_count
    remove_column :members, :current_sign_in_at
    remove_column :members, :last_sign_in_at
    remove_column :members, :current_sign_in_ip
    remove_column :members, :last_sign_in_ip

    remove_index :members, :email,                unique: true
    remove_index :members, :reset_password_token, unique: true
  end
end
