class AddTalkNotificationToAdmins < ActiveRecord::Migration[4.2]
  def change
    add_column :admins, :talk_notification, :boolean, :default => false
  end
end
