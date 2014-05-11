class AddVerifiedToMembers < ActiveRecord::Migration
  def change
    add_column :members, :verified, :boolean
  end
end
