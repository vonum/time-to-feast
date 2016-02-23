class CreateTableRestaurantsMeals < ActiveRecord::Migration
  def change
    create_table :restaurants_meals do |t|
      t.belongs_to :restaurant, index: true, null: false
      t.belongs_to :meal, index: true, null: false
    end
  end
end
