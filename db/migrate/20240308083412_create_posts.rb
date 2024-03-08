class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :author_id, foreign_key: {to_table: :users}
      t.string :title, null:  false
      t.text :body, null: false
      t.string :thumbnail, null: false
      t.references :category_id, foreign_key: {to_table: :categories}
      t.references :location_id, foreign_key: {to_table: :locations}

      t.timestamps
    end
  end
end
