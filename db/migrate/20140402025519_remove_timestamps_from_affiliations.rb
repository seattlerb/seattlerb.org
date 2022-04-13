class RemoveTimestampsFromAffiliations < ActiveRecord::Migration[4.2]
  def up
    remove_column :affiliations, :created_at
    remove_column :affiliations, :updated_at
  end

  def down
    add_timestamps(:affliations)
  end
end
