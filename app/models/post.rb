class Post < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 25 }

  with_options presence: true do
    validates :title
    validates :content
    validates :image
  end
  
  mount_uploader :image, ImageUploader
end
