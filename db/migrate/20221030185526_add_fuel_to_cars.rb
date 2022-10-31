class AddFuelToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :fuel, :float
  end
end
