class AddDataToRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :initial_fuel, :float
  end
end
