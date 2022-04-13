class AddVerifiedToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :verified, :boolean, default: false
  end
end
