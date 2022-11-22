class AddCoordsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :coords_x, :double
    add_column :users, :coords_y, :double
  end
end
