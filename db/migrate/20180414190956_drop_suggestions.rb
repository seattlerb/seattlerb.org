class DropSuggestions < ActiveRecord::Migration
  def up
    drop_table :suggestions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
