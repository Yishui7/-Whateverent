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

# @descriptions = [
#   "Welcome to our Cardio Home Gym! Our gym is equipped with everything you need to get your heart pumping and your body moving. We have top-of-the-line treadmills, stationary bikes, and rowing machines to help you burn calories and improve your cardiovascular health. Our gym has a lively and energetic vibe, with upbeat music to keep you motivated throughout your workout. Whether you're a beginner or an experienced athlete, our Cardio Home Gym is perfect for anyone looking to improve their fitness and health.",
#   "Welcome to our Machine Weights Home Gym! Our gym is fully equipped with a variety of weight machines to help you build strength and muscle. We have everything from leg presses to chest presses to lat pulldown machines. Our gym has a focused and determined vibe, perfect for serious lifters who are looking to push themselves to their limits. Whether you're a beginner or an advanced lifter, our Machine Weights Home Gym is perfect for anyone looking to build muscle and increase their strength.",
#   "Welcome to our Free Weights Home Gym! Our gym is equipped with a wide range of free weights, including dumbbells, barbells, and kettlebells. We have everything you need to perform a variety of exercises and work on your strength training. Our gym has a welcoming and supportive vibe, perfect for anyone who wants to lift weights in a friendly and encouraging environment. Whether you're a beginner or an experienced lifter, our Free Weights Home Gym is perfect for anyone who wants to work on their strength and improve their fitness.",
#   "Welcome to my calisthenics home gym! Equipped with a pull-up bar, dip station, resistance bands, and kettlebells, this gym has everything you need to get a full-body workout. The vibe is energetic and upbeat, perfect for those who want to push themselves to their limits. This gym is suited for anyone who is interested in bodyweight training and wants to improve their strength and endurance. Whether you're a beginner or an experienced athlete, this gym is perfect for you.",
#   "Welcome to my home yoga studio! With a yoga mat, blocks, straps, and bolsters, this studio is fully equipped for a peaceful yoga practice. The vibe is calm and serene, with soft lighting and soothing music. This studio is suited for anyone who wants to relax and de-stress, as well as those who want to improve their flexibility and balance. Whether you're a beginner or an experienced yogi, this studio is perfect for you. Take a deep breath and lets begin our practice together. Namaste."
# ]

# Gym::CATEGORIES.each_with_index do |cat, i|
#   cat[0].description = @descriptions[i]
# end

puts "Creating new gyms"

6.times do
  @category = Gym::CATEGORIES.sample
  gym = Gym.new(
    # user_id = users.last.id
    # id_user: user_id,
    user: @owner.sample,
    price_per_hour: Faker::Number.between(from: 1, to: 10),
    address: @address.sample,
    category: @category[:name],
    description: @category[:description],
    name: Faker::Games::LeagueOfLegends.champion,
    capacity: Faker::Number.between(from: 2, to: 5)
  )

  puts "Uploading photos for #{gym.name}"
  5.times do
    file = URI.open("https://source.unsplash.com/random/?gym")
    gym.photos.attach(io: file, filename: "gym.jpg", content_type: "image/jpg")
    sleep(2)
  end

  gym.save
  puts "Created #{gym.name}"
end



# For Seeds:
# 1. Make a description array that will be super long and annoying but then we will have
#     good descriptions instead of lorem ipsum shit
