class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|

      t.belongs_to :user, index: true, :null => false
      t.belongs_to :reservation, index: true, :null => false

      t.timestamps
    end
  end
end
