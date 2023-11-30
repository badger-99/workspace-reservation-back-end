class Workspace < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
end
