class AddRubyGemsIdToDude < ActiveRecord::Migration
  def change
    add_column :dudes, :ruby_gems_id, :string
  end
end
