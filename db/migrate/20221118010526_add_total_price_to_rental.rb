class AddTotalPriceToRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :totalPrice, :float, defoult: 0
  end
end
