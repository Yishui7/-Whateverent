class CreateGyms < ActiveRecord::Migration[7.0]
  def change
    create_table :gyms do |t|
      t.integer :price
      t.string :address
      t.text :description
      t.string :category
      t.string :name
      t.integer :capacity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
