class User < ActiveRecord::Base
	validates :fbid, presence: true
	validates_uniqueness_of :fbid
end
