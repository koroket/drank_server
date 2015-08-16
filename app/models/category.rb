class Category < ActiveRecord::Base
	has_many :drink_categories, :class_name => DrinkCategory, :inverse_of => :category, :dependent => :destroy
	has_many :drinks, :through => :drink_categories

	has_many :subscriptions, :class_name => Subscription, :inverse_of => :category, :dependent => :destroy
	has_many :users, :through => :subscriptions
end
