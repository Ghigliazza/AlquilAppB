class AddTurnonToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :turned_on, :boolean
  end
end
