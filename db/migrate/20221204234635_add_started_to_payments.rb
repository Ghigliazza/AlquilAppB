class AddStartedToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :started, :datetime
  end
end
