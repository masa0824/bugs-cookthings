class CreateSelectImages < ActiveRecord::Migration[6.1]
  def change
    create_table :select_images do |t|
      t.integer :sort_num, limit: 4
      t.string :name, limit: 255
      #t.timestamps
    end
    add_reference :recipes, :select_images, default: 0, null: false, comment: "0 -> 未使用｜1以上 -> 指定画像"
    add_reference :recipe_templates, :select_images, default: 0, null: false, comment: "0 -> 未使用｜1以上 -> 指定画像"
    #remove_column :recipes, :select_image
    #remove_column :recipe_templates, :select_image
  end
end