class RemoveFeaturedFromMembers < ActiveRecord::Migration[4.2]
  def change
    remove_column :members, :featured, :boolean
  end
end
