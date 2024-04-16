class Post < ApplicationRecord


    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    belongs_to :category
    belongs_to :location

    has_one_attached :thumbnail, dependent: :purge_later, service: :local
    validate :correct_thumbnail_type
    validate :thumbnail_size

    scope :by_category_name, ->(title) { joins(:category).where(categories: { title: title }) }
    scope :by_location, ->(title) { joins(:category).where(locations: { title: title }) }

    
    private  
    
    def correct_thumbnail_type
        unless thumbnail.attached?
            errors.add(:thumbnail, 'must be present')
        end
        if thumbnail.attached? && !thumbnail.content_type.in?(%w(image/png image/jpeg))
          errors.add(:thumbnail, 'must be a PNG, JPG or JPEG file')
          thumbnail.purge # Delete the attached file
        end
    end

    def thumbnail_size
        if thumbnail.attached?
          if thumbnail.blob.byte_size > 3.megabytes
            errors.add(:thumbnail, 'must be less than 5MB')
            thumbnail.purge  # Remove the attachment
          end        
        end
    end

end
