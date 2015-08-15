class Ingredient < ActiveRecord::Base
	has_many :drink_ingredients, :class_name => DrinkIngredient, :inverse_of => :ingredient, :dependent => :destroy
	has_many :drinks, :through => :drink_ingredients

	def self.search(query)
		ingredients = Ingredient.where("ingredients.name LIKE '%#{query}%'")
	end
end