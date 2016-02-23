class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|

      t.string :name, null: false
      t.string :description, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
