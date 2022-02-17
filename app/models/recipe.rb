class Recipe < ApplicationRecord
    has_many :food_stuffs, dependent: :destroy
    has_one_attached :recipe_image
    accepts_nested_attributes_for :food_stuffs, allow_destroy: true

    # 画像アップロードのバリデーター
    validates :recipe_image,
        content_type: {
            in: %w[image/jpeg image/gif image/png],
            message: "画像ファイルのフォーマットが違います"
        },
        size:{
            less_than: 5.megabytes,
            message: "ファイルは5MB以下にして下さい"
        }
end
