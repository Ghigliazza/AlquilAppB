class RemoveFuelFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :fuel, :integer
  end
end
