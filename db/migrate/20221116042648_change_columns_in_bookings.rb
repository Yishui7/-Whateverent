class ChangeColumnsInBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :date
    remove_column :bookings, :start_time
    remove_column :bookings, :end_time
    add_column :bookings, :date, :date
    add_column :bookings, :start_time, :time
    add_column :bookings, :end_time, :time
  end
end
