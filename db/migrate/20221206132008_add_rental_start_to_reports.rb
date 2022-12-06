class AddRentalStartToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :rental_start, :datetime
    add_column :reports, :last_user_id, :integer
    add_column :reports, :engine_turned_on, :boolean
  end
end
