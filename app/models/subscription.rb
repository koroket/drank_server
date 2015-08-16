class Subscription < ActiveRecord::Base
	belongs_to :category
 	belongs_to :user

	has_many :drinks, :through => :category

	has_many :likes
	has_many :dislikes

	def self.recommend

	end
end
