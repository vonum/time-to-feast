class ChangeUsernameForAdminV2 < ActiveRecord::Migration
  def change
  	change_column :admins, :username, :string, null: false, unique: true
  end
end
