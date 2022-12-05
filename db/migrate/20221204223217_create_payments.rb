class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.float :price
      t.datetime :expires
      t.integer :rent_hs
      t.datetime :cancel
      t.integer :rental_id

      t.timestamps
    end
  end
end
