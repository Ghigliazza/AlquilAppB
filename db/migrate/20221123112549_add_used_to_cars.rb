class AddUsedToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :used, :boolean
  end
end
