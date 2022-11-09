class ChangeStateToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :state, :integer, default: 0
  end
end
