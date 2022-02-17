class RecipeTemplate < ApplicationRecord
    has_many :food_stuff_templates, dependent: :destroy
    has_one_attached :recipe_template_image
    accepts_nested_attributes_for :food_stuff_templates, allow_destroy: true

    # 画像アップロードのバリデーター
    validates :recipe_template_image,
        content_type: {
            in: %w[image/jpeg image/gif image/png],
            message: "画像ファイルのフォーマットが違います"
        },
        size:{
            less_than: 5.megabytes,
            message: "ファイルは5MB以下にして下さい"
        }
end
