class AddSuggesterToSuggestions < ActiveRecord::Migration[4.2]
  def change
    add_column :suggestions, :suggester, :string
  end
end
