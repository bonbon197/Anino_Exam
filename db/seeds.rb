# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#wipe current data
Entry.destroy_all
Leaderboard.destroy_all
User.destroy_all


#create 100 users
100.times do |i|
    User.create(name: "User #{i}")
end

#create 100 leaderboards
100.times do |i|
    Leaderboard.create(name: "Leaderboard #{i}")
end

#create 100 random entries to random leaderboards from random users
100.times do |i|
    user_id = User.order("RANDOM()").first._id
    leaderboard_id = Leaderboard.order("RANDOM()").first._id
    Entry.create(user_id: user_id, leaderboard_id: leaderboard_id, score: rand(1..100))
  end

