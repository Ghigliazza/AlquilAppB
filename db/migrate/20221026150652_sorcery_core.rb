class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt

      t.integer :rol
      t.string :name
      t.string :lastName
      t.integer :document,        null: false, index: { unique: true }
      t.boolean :state
      t.string :license_url
      t.string :blueCard_url
      t.integer :position_id
      

      t.timestamps                null: false
    end
  end
end
