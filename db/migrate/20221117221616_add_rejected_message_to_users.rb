class AddRejectedMessageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rejectedMessage, :text
  end
end
