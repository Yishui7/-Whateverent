class Gym < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :bookings
  validates :price_per_hour, presence: true
  validates :address, presence: true
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :capacity, presence: true
  validates :description, presence: true
  # validates :photo, presence: true
end
