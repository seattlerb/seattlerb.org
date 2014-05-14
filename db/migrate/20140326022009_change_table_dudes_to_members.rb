class ChangeTableDudesToMembers < ActiveRecord::Migration
  def change
    rename_table(:dudes, :members)
    rename_column(:affiliations, :dude_id, :member_id)
  end
end
