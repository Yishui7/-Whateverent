class Booking < ApplicationRecord
  STATUS = ['pending', 'confirmed', 'rejected', 'cancelled']
  belongs_to :user
  belongs_to :gym
  validates :date, presence: true
  validates :clients, presence: true, comparison: { greater_than: 0 }
  validates :status, inclusion: { in: STATUS }
  validates :date, comparison: { greater_than_or_equal_to: Date.today }
  validates :start_time, presence: true, uniqueness: { scope: %I[date gym] }
  validate :clients_capacity
  validate :start_time_date_scope
  validates :start_time, comparison: { less_than: :end_time }
  validates :duration, comparison: { greater_than_or_equal_to: 1, message: 'Duration must be one hour or longer' }

  def clients_capacity
    if clients
      errors.add(:clients, 'must be less than the capacity of the gym') if clients > gym.capacity
    end
  end

  def start_time_date_scope
    start_of = date.to_datetime + start_time.hour.hours + start_time.min.minutes
    errors.add(:start_time, 'must be in the future') if start_of < DateTime.now
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
