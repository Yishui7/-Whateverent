class Gym < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  CATEGORIES = [
    { name: "Cardio", description: "Welcome to our Cardio Home Gym! Our gym is equipped with everything you need to get your heart pumping and your body moving. We have top-of-the-line treadmills, stationary bikes, and rowing machines to help you burn calories and improve your cardiovascular health. Our gym has a lively and energetic vibe, with upbeat music to keep you motivated throughout your workout. Whether you're a beginner or an experienced athlete, our Cardio Home Gym is perfect for anyone looking to improve their fitness and health."},
    { name: "Machine Weights", description: "Welcome to our Machine Weights Home Gym! Our gym is fully equipped with a variety of weight machines to help you build strength and muscle. We have everything from leg presses to chest presses to lat pulldown machines. Our gym has a focused and determined vibe, perfect for serious lifters who are looking to push themselves to their limits. Whether you're a beginner or an advanced lifter, our Machine Weights Home Gym is perfect for anyone looking to build muscle and increase their strength." },
    { name: "Free Weights", description: "Welcome to our Free Weights Home Gym! Our gym is equipped with a wide range of free weights, including dumbbells, barbells, and kettlebells. We have everything you need to perform a variety of exercises and work on your strength training. Our gym has a welcoming and supportive vibe, perfect for anyone who wants to lift weights in a friendly and encouraging environment. Whether you're a beginner or an experienced lifter, our Free Weights Home Gym is perfect for anyone who wants to work on their strength and improve their fitness." },
    { name: "Calistenics", description: "Welcome to my calisthenics home gym! Equipped with a pull-up bar, dip station, resistance bands, and kettlebells, this gym has everything you need to get a full-body workout. The vibe is energetic and upbeat, perfect for those who want to push themselves to their limits. This gym is suited for anyone who is interested in bodyweight training and wants to improve their strength and endurance. Whether you're a beginner or an experienced athlete, this gym is perfect for you." },
    { name: "Yoga", description: "Welcome to my home yoga studio! With a yoga mat, blocks, straps, and bolsters, this studio is fully equipped for a peaceful yoga practice. The vibe is calm and serene, with soft lighting and soothing music. This studio is suited for anyone who wants to relax and de-stress, as well as those who want to improve their flexibility and balance. Whether you're a beginner or an experienced yogi, this studio is perfect for you. Take a deep breath and lets begin our practice together. Namaste." }
  ]
  has_many_attached :photos
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :price_per_hour, presence: true
  validates :address, presence: true
  validates :name, presence: true, uniqueness: true
  # validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :category, presence: true, inclusion: { in: CATEGORIES.map { |category| category[:name] } }
  validates :capacity, presence: true
  validates :description, presence: true
  validates :photos, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_category,
                  against: [:category],
                  using: {
                    tsearch: { prefix: true }
                  }
end
