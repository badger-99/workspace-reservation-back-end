class Workspace < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

  has_one_attached :image

  has_many :reservations, dependent: :destroy

  validate :image_presence

  private

  def image_presence
    errors.add(:image, 'Image must be uploaded') unless image.attached?
  end
end
