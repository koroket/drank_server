class User < ActiveRecord::Base
	validates :fbid, presence: true
	validates_uniqueness_of :fbid

	has_many :subscriptions, :class_name => Subscription, :inverse_of => :user, :dependent => :destroy
	has_many :categories, :through => :subscriptions

	has_many :favorites, :class_name => Favorite, :inverse_of => :user, :dependent => :destroy
	has_many :favorite_drinks, :through => :favorites, :source => :drink
end
