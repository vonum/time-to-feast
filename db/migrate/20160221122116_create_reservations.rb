class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|

      t.date :date, :null => false
      t.time :start, :null => false
      t.time :finish, :null => false

      t.belongs_to :user, index: true
      t.belongs_to :table, index: true

      t.timestamps
    end
  end
end
