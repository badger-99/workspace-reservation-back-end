# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a user

User.create(username: "testuser1")

User.create(username: "testuser2")

User.create(username: "testuser3")

# Add a workspace

# Workspace.create(name: "testworkspace1", location: "testlocation1", capacity: 1)

# Workspace.create(name: "testworkspace2", location: "testlocation2", capacity: 2)

# Add a reservation

# Reservation.create(user_id: 1, workspace_id: 1, start_time: "2021-10-01 10:00:00", end_time: "2021-10-01 11:00:00")

# Reservation.create(user_id: 2, workspace_id: 2, start_time: "2021-10-01 10:00:00", end_time: "2021-10-01 11:00:00")
