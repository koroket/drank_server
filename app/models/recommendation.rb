class Recommendation < ActiveRecord::Base
	belongs_to :drink
 	belongs_to :subscription
end
