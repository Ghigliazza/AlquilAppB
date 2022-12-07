class RemoveSummaryToRental < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :summary, :text
  end
end
