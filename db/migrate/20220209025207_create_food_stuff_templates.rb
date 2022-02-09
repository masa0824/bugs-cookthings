class CreateFoodStuffTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :food_stuff_templates do |t|
      t.string :food_stuff, limit: 255
      t.integer :amount, limit: 4
      t.string :mass, limit: 255
      t.references :recipe_template, foreign_key: true
      t.timestamps
    end
  end
end
