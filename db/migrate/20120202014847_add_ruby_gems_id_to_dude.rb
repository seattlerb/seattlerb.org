class AddRubyGemsIdToDude < ActiveRecord::Migration[4.2]
  def change
    add_column :dudes, :ruby_gems_id, :string
  end
end
