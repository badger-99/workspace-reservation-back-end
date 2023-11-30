class User < ApplicationRecord
  # This File is Subject to Change as the App is Developed

  # devise token auth to be implemented later using unique username only

  has_many :reservations, dependent: :destroy # only works if reservation model setup accurately.
  has_many :workspaces, through: :reservations # only works if the workspace model setup accurately.

  validates :username, presence: true, uniqueness: true
end
