class Reservation < ApplicationRecord
  # To enable when the user and workspace models are created
  # belongs_to :user
  # belongs_to :workspace
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :city, presence: true
  validates :workspace, presence: true
  validates :user, presence: true
end
