class DrinkCategory < ActiveRecord::Base
	belongs_to :drink
 	belongs_to :category
end
