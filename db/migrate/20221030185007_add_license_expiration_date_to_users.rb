class AddLicenseExpirationDateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :licenseExpiration, :date
  end
end
