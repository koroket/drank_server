class Drink < ActiveRecord::Base
	has_many :drink_ingredients, :class_name => DrinkIngredient, :inverse_of => :drink, :dependent => :destroy
	has_many :ingredients, :through => :drink_ingredients

	has_many :drink_categories, :class_name => DrinkCategory, :inverse_of => :drink, :dependent => :destroy
	has_many :categories, :through => :drink_categories

	has_many :likes

	validates_uniqueness_of :name
	validates :name, length: { minimum: 1 }

	def self.contains_ingredient(query)
		drinks = Drink.joins(:ingredients).where("ingredients.name LIKE '%#{query}%'").select('drinks.*')
	end

	def self.contains_ingredients(query)
		drinks = Drink.joins(:ingredients).where("lower(ingredients.name) ILIKE ANY ( array[?] )", query).select('drinks.*')
	end

	def self.favorites(count)
		drinks = Drink.all.limit(count)
	end
end