class AddStateToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :state, :integer
  end
end
