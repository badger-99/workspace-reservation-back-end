class User < ApplicationRecord

  # devise token auth to be implemented later using unique username only

  has_many :reservations, dependent: :destroy # only works if the reservation has a user_id and reservation model setup accurately.
  has_many :workspaces, through: :reservations # only works if the workspace model has a reservation_id and workspace model setup accurately.

  validates :username, presence: true, uniqueness: true
end
