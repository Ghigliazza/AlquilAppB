class RemoveTotalPriceToRental < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :totalPrice, :float, default: 0
  end
end
