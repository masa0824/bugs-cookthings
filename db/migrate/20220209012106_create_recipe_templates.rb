class CreateRecipeTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_templates do |t|
      t.string :recipe_name, limit: 255
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
