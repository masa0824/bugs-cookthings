class AddColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :select_images, :name, :food_name
    add_column :select_images, :file_name, :string, limit: 255
  end
end
