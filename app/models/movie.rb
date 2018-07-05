class Movie < ApplicationRecord
                     #컬럼       업로더
    mount_uploader :image_path, ImageUploader
    has_many :likes
    has_many :users,through: :likes
    
    has_many :comments
end
