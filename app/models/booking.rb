class Booking < ApplicationRecord
  STATUS = ['pending', 'confirmed', 'rejected', 'cancelled']
  belongs_to :user
  belongs_to :gym
  validates :status, presence: true, inclusion: { in: STATUS }
  validates :date, presence: true
  validates :start_time, presence: true, uniqueness: { scope: :date }
end

# t.integer "date"
# t.integer "start_time"
# t.integer "end_time"
# t.integer "price_total"
# t.string "status"

# Canelled can only be done by booking creator
# Confirm/Reject can only be done by Gym Owner
