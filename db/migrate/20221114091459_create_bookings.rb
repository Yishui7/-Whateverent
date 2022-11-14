class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :date
      t.integer :start_time
      t.integer :end_time
      t.integer :price_total
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :gym, null: false, foreign_key: true

      t.timestamps
    end
  end
end
