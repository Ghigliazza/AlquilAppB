class AddTransmissionToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :transmission, :string
  end
end
