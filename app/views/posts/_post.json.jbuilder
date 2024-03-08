json.extract! post, :id, :author_id, :title, :body, :thumbnail, :category_id, :location_id, :created_at, :updated_at
json.url post_url(post, format: :json)
