class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gym
end
# t.integer "date"
# t.integer "start_time"
# t.integer "end_time"
# t.integer "price_total"
# t.string "status"
