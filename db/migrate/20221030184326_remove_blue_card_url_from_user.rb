class RemoveBlueCardUrlFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :blueCard_url, :string
  end
end
