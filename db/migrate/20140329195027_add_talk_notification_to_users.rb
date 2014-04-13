class AddTalkNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :talk_notification, :boolean, :default => false
  end
end
