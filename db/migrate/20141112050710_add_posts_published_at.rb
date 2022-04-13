class AddPostsPublishedAt < ActiveRecord::Migration[4.2]
  def up
    add_column :posts, :published_at, :datetime
  end

  def down
    remove_column :posts, :published_at
  end
end
