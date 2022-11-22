class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :brand
      t.string :license
      t.string :color
      t.string :img_url
      t.integer :doors
      t.integer :seats
      t.integer :state
      t.boolean :engine
      t.integer :fuel
      t.integer :position_id

      t.timestamps
    end
  end
end
