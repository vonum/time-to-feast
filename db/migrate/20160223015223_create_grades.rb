class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|

      t.belongs_to :user, index: true, :null => false
      t.belongs_to :event, index: true, :null => false

      t.integer :grade, :null => false

      t.timestamps
    end
  end
end
