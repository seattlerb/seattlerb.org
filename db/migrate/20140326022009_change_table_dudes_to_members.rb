class ChangeTableDudesToMembers < ActiveRecord::Migration[4.2]
  def change
    rename_table(:dudes, :members)
    rename_column(:affiliations, :dude_id, :member_id)
  end
end
