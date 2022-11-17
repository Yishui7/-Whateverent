class Booking < ApplicationRecord
  STATUS = ['pending', 'confirmed', 'rejected', 'cancelled']
  belongs_to :user
  belongs_to :gym
  validates :category, presence: true, inclusion: { in: STATUS }
end

# t.integer "date"
# t.integer "start_time"
# t.integer "end_time"
# t.integer "price_total"
# t.string "status"

# Canelled can only be done by booking creator
# Confirm/Reject can only be done by Gym Owner
