class RecipeTemplate < ApplicationRecord
    has_many :food_stuff_templates, dependent: :destroy
    has_one_attached :recipe_template_image
    accepts_nested_attributes_for :food_stuff_templates, allow_destroy: true
end
