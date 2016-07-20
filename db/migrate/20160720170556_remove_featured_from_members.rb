class RemoveFeaturedFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :featured, :boolean
  end
end
