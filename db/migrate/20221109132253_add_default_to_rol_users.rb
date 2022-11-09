class AddDefaultToRolUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :rol, :integer, default: 2
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
