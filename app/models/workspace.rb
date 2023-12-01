class Workspace < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :image, presence: true, allow_blank: false

  has_many :reservations, dependent: :destroy
end
