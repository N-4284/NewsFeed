class RemoveThumbnailFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :thumbnail
  end
end
