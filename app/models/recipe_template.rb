class RecipeTemplate < ApplicationRecord
    has_many :food_stuffs, dependent: :destroy
    has_one_attached :recipe_image
    accepts_nested_attributes_for :food_stuffs, allow_destroy: true
end
