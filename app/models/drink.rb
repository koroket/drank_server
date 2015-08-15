class Drink < ActiveRecord::Base
	has_many :drink_ingredients, :class_name => DrinkIngredient, :inverse_of => :drink, :dependent => :destroy
	has_many :ingredients, :through => :drink_ingredients
	validates_uniqueness_of :name

	def self.contains_ingredient(query)
		drinks = Drink.joins(:ingredients).where("ingredients.name LIKE '%#{query}%'").select('drinks.*')
	end

	def self.contains_ingredients(query)
		drinks = Drink.joins(:ingredients).where("lower(ingredients.name) REGEXP ?", query.join('|')).select('drinks.*')
	end

	def self.favorites(count)
		drinks = Drink.all.limit(count)
	end
end