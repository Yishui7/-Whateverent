class Booking < ApplicationRecord
  STATUS = ['pending', 'confirmed', 'rejected', 'cancelled']
  belongs_to :user
  belongs_to :gym
  validates :status, inclusion: { in: STATUS }
  validates :date, presence: true
  validates :start_time, presence: true, uniqueness: { scope: %I[date gym] }
  # validates :clients, numericality: { less_than:  }
  validate :clients_capacity

  # validates_accosiated :clients, numericality: { less_than: :capacity}

  def clients_capacity
    errors.add(:clients, 'must be less than the capacity of the gym') if clients > gym.capacity
  end
end

# create_table "bookings", force: :cascade do |t|
#     t.string "status"
#     t.bigint "user_id", null: false
#     t.bigint "gym_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.integer "duration"
#     t.integer "total_price"
#     t.integer "clients"
#     t.date "date"
#     t.time "start_time"
#     t.time "end_time"
#     t.index ["gym_id"], name: "index_bookings_on_gym_id"
#     t.index ["user_id"], name: "index_bookings_on_user_id"

# Canelled can only be done by booking creator
# Confirm/Reject can only be done by Gym Owner
