class Workspace < ApplicationRecord
  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :price_per_day, presence: true, allow_blank: false

  has_one_attached :image

  has_many :reservations, dependent: :destroy

  validate :image_presence

  # Returns the image URL from the ActiveStorage Blob table
  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  private

  def image_presence
    errors.add(:image, 'Image must be uploaded') unless image.attached?
  end
end
