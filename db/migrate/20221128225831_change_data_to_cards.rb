class ChangeDataToCards < ActiveRecord::Migration[7.0]

  def change
    add_column :cards, :bankName, :integer, default: Card.bankNames[:Otro]
    add_column :cards, :balance, :integer, default: 0
    rename_column :cards, :cardNumber, :number
  end
end