class AddUsernameToAdmins < ActiveRecord::Migration
  def change
  	add_column :admins, :username, :string, unique: true
  end
end
