class Gym < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  CATEGORIES = [
    "Cardio",
    "Machine Weights",
    "Free Weights",
    "Calistenics",
    "Yoga"
  ]
  has_many_attached :photos
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :price_per_hour, presence: true
  validates :address, presence: true
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :capacity, presence: true
  validates :description, presence: true
  validates :photos, presence: true
end
