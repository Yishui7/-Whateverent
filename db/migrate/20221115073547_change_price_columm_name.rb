class ChangePriceColummName < ActiveRecord::Migration[7.0]
  def change
    rename_column(:gyms, :price, :price_per_hour)

  end
end
