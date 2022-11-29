class ChangeDataToCards < ActiveRecord::Migration[7.0]

  def change
    add_column :cards, :bankName, :string, default: "notfound.jpg"
    rename_column :cards, :cardNumber, :number
  end
end