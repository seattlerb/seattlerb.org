class AddSuggesterToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :suggester, :string
  end
end
