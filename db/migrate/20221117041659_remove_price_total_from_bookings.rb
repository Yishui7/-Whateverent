class RemovePriceTotalFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :price_total, :integer
  end
end
