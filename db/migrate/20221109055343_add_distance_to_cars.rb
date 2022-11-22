class AddDistanceToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :distance, :float
  end
end
