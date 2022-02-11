class CreateRecipeTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_templates do |t|
      t.string :recipe_name, limit: 255
      t.string :category, limit: 255
      t.datetime :cook_at
      t.references :user, foreign_key: true
      t.boolean :is_original, default: false, null: false
      t.timestamps
    end
  end
end
