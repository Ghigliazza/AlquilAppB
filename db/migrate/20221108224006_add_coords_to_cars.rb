class AddCoordsToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :coords_x, :double
    add_column :cars, :coords_y, :double
  end
end
