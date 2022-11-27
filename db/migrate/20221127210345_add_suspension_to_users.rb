class AddSuspensionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :suspended_until, :date
    add_column :users, :suspended_for, :text
  end
end
