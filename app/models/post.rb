class Post < ApplicationRecord


    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    belongs_to :category
    belongs_to :location

    #has_one_attached :thumbnail
    has_one_attached :thumbnail, dependent: :purge_later, service: :local
    #problem causer^^ (i have old db which stores thumb at assets\images\thumbnails or somthin)
end
