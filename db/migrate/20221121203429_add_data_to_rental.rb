class AddDataToRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :total_hours, :integer
    add_column :rentals, :initial_fuel, :float
    add_column :rentals, :summary, :text
  end
end
