class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  validates :username, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  has_one_attached :profile_picture
  validate :correct_image_type
  validate :image_size

  has_many :posts, foreign_key: :author_id, dependent: :nullify

  after_create :assign_default_role
  
  private  
    
    def correct_image_type
        unless profile_picture.attached?
            errors.add(:profile_picture, 'must be present')
        end
        if profile_picture.attached? && !profile_picture.content_type.in?(%w(image/png image/jpeg))
          errors.add(:profile_picture, 'must be a PNG, JPG or JPEG file')
          profile_picture.purge # Delete the attached file
        end
    end

    def image_size
        if profile_picture.attached?
          if profile_picture.blob.byte_size > 2.megabytes
            errors.add(:profile_picture, 'must be less than 5MB')
            profile_picture.purge  # Remove the attachment
          end        
        end
    end

    def assign_default_role
      self.add_role(:writer) # Assign 'user' role to new users
    end

end
