class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :description
      t.string :user_id
      t.string :car_id

      t.timestamps
    end
  end
end
