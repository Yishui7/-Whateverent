class AddCoordinatesToGyms < ActiveRecord::Migration[7.0]
  def change
    add_column :gyms, :latitude, :float
    add_column :gyms, :longitude, :float
  end
end
