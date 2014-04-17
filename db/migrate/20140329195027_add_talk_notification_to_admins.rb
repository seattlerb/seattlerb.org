class AddTalkNotificationToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :talk_notification, :boolean, :default => false
  end
end
