class AddGuiltyToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :guilty, :integer
  end
end
