class AddLicenseNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :licenseNumber, :integer
  end
end
