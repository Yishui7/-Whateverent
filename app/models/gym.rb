class Gym < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :price, presence: true
  validates :address, presence: true
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :capacity, presence: true
  validates :description, presence: true
end
