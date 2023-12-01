# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(username: 'Abdul')
User.create(username: 'Zilola')
User.create(username: 'Javier')
User.create(username: 'Alfred')

Workspace.create(name: 'Room 1',description: 'A nice room.',image: 'https://i.pinimg.com/originals/79/d7/85/79d785f197df5dd6c8f1cfb9ed669812.jpg')
Workspace.create(name: 'Room 2',description: 'An even nicer room.',image: 'https://accruewp.co.uk/wp-content/uploads/2019/02/co-working-office-space-guildford.jpeg')
Workspace.create(name: 'Room 3',description: 'A really really noce room.',image: 'https://www.rukita.co/stories/wp-content/uploads/2020/01/coworking-space-in-jakarta.jpg')
Workspace.create(name: 'Room 4',description: 'Brobably the best room.',image: 'https://www.richmontsthailand.com/application/files/7015/4642/4755/Co-working_space_2.jpg')

Reservation.create(city: 'Tokyo', start_date: Date.now, end_date: Date.now, user_id: '3', workspace_id: '2')
Reservation.create(city: 'Bali', start_date: Date.now, end_date: Date.now, user_id: '2', workspace_id: '3')
Reservation.create(city: 'Reykjavik', start_date: Date.now, end_date: Date.now, user_id: '1', workspace_id: '4')
Reservation.create(city: 'Lisbon', start_date: Date.now, end_date: Date.now, user_id: '4', workspace_id: '1')
