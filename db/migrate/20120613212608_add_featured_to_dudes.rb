class AddFeaturedToDudes < ActiveRecord::Migration
  def up
    add_column :dudes, :featured, :boolean, default: false
    add_column :dudes, :twitter, :string
    add_column :dudes, :github, :string
    add_column :dudes, :image_url, :string
    change_column :dudes, :bio, :text
  end
  
  def down
    remove_column :dudes, :image_url, :string
    remove_column :dudes, :twitter, :string
    remove_column :dudes, :github, :string
    remove_column :dudes, :featured
    change_column :dudes, :bio, :string
  end
end