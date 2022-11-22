class ExtendedRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :state, :integer, default: 1000
  end
end
