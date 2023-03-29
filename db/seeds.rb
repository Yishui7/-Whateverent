# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'

puts "Detroying users"
Gym.destroy_all
User.destroy_all


puts "Creating new users"
10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123"
  )
  user.save
  puts "Created #{user.first_name}"
end

@owner = User.all

@address = [
  "2331 E Washington St",
  "2467 Heather Glen Ave",
  "12 Schilling St",
  "1100 N Frontage Rd",
  "1214 E Wellington St",
  "69 West St"
]

puts "Creating new gyms"

6.times do
  gym = Gym.new(
    # user_id = users.last.id
    # id_user: user_id,
    user: @owner.sample,
    price_per_hour: Faker::Number.between(from: 1, to: 10),
    address: @address.sample,
    description: Faker::Lorem.sentence(word_count: 40),
    category: Gym::CATEGORIES.sample,
    name: Faker::Games::LeagueOfLegends.champion,
    capacity: Faker::Number.between(from: 1, to: 5)
  )

  puts "Uploading photos for #{gym.name}"
  5.times do
    file = URI.open("https://source.unsplash.com/random/?gym")
    gym.photos.attach(io: file, filename: "{SecureRandom.hex(10)}.jpg", content_type: "image/jpg")
  end

  gym.save
  puts "Created #{gym.name}"
end
