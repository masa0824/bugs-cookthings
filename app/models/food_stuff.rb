class FoodStuff < ApplicationRecord
    belongs_to :recipe

    validates :food_stuff,
        presence: true,
        length: { maximum: 20 }
    
    validates :amount,
        presence: true,
        numericality: {greater_than_or_equal_to: 1}
    
    validates :mass,
        presence: true,
        length: { maximum: 20 }
end
