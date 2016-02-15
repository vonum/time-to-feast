class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|

      t.integer :noseats

      t.references :restaurant, index: true, foreign_key: true

      t.timestamps
    end
  end
end
