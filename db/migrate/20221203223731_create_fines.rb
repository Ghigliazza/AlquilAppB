class CreateFines < ActiveRecord::Migration[7.0]
  def change
    create_table :fines do |t|
      t.float :amount
      t.text :motive
      t.integer :user_id

      t.timestamps
    end
  end
end
