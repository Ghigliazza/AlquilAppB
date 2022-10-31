class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.float :price
      t.datetime :expires
      t.integer :user_id
      t.integer :car_id

      t.timestamps
    end
  end
end
