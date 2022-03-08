class CreateRecipeTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_templates do |t|
      t.string :recipe_name, limit: 255
      t.string :category, limit: 255 #「朝食」「昼食」「夕食」などを入力
      t.datetime :cook_at
      t.references :user, foreign_key: true
      t.boolean :is_original, default: false, null: false
      #t.integer :select_image, limit: 4, default: 0, null: false, comment: "0 -> 未使用｜1以上 -> 指定画像"
      #t.references :select_images, limit: 4, default: 0, null: false, foreign_key: true, comment: "0 -> 未使用｜1以上 -> 指定画像"
      t.string :kind, limit: 255 #「中華」「和風」「フレンチ」などを入力
      t.timestamps
    end
  end
end
