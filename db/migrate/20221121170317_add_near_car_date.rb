class AddNearCarDate < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :dateCarNear, :datetime
  end
end
