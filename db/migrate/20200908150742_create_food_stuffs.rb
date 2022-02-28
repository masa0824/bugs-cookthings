class CreateFoodStuffs < ActiveRecord::Migration[6.0]
  def change
    create_table :food_stuffs do |t|
      t.string :food_kind, limit: 255
      t.string :food_stuff, limit: 255
      t.integer :amount, limit: 4
      t.string :mass, limit: 255
      t.references :recipe, foreign_key: true
      t.timestamps
    end
  end
end
