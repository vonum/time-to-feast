class ChangeUsernameForAdmin < ActiveRecord::Migration
  def change
  	change_column :admins, :username, :string, null: true, unique: true
  end
end
