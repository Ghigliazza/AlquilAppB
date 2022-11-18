class AddBirthdateAndRejectedMessageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthdate, :date
    add_column :users, :rejectedMessage, :text
  end
end
