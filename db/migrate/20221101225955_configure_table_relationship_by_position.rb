class ConfigureTableRelationshipByPosition < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :position_id, :integer
    remove_column :cars, :position_id, :integer
    add_column :positions, :user_id, :integer
    add_column :positions, :cars_id, :integer
  end
end
