# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

puts "Detroying users"
User.destroy_all

puts "Creating new users"
4.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123"
  )
  puts "Created #{user.first_name}"
  user.save
end

puts "Creating new gyms"
15.times do
  gym = Gym.new(
    # user_id = users.last.id
    # id_user: user_id,
    user: User.first,
    price_per_hour: Faker::Number.between(from: 1, to: 10),
    address: Faker::Address.street_address,
    description: Faker::Lorem.sentence(word_count: 20),
    category: Gym::CATEGORIES.sample,
    name: Faker::Cannabis.brand,
    capacity: Faker::Number.between(from: 1, to: 5)
  )
  puts "Created #{gym.name}"
  gym.save
end
