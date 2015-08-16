class User < ActiveRecord::Base
	validates :fbid, presence: true
	validates_uniqueness_of :fbid

	has_many :subscriptions, :class_name => Subscription, :inverse_of => :user, :dependent => :destroy
	has_many :categories, :through => :subscriptions
end
