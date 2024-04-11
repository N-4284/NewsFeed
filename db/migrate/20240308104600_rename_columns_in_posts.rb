class RenameColumnsInPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :author_id_id, :author_id
    rename_column :posts, :category_id_id, :category_id
    rename_column :posts, :location_id_id, :location_id
  end
end
