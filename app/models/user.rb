class User < ApplicationRecord
  # This File is Subject to Change as the App is Developed

  # devise auth if we have to implement

  has_many :reservations, dependent: :destroy # only works if reservation model setup accurately.
  # has_many :workspaces, through: :reservations # only works if the workspace model setup accurately.

  # username must be unique and present in order to create a user and not null
  validates :username, presence: true, uniqueness: true, allow_blank: false
end
