class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.integer :cardNumber
      t.date :expires
      t.integer :user_id

      t.timestamps
    end
  end
end
