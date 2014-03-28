class ChangeIndexesUsersToAdmins < ActiveRecord::Migration
  def change
    rename_index :admins, 'index_users_on_email', 'index_admins_on_email'
    rename_index :admins, 'index_users_on_reset_password_token', 'index_admins_on_reset_password_token'
  end
end
