class AddDurationToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :duration, :integer
    add_column :bookings, :total_price, :integer
  end
end
