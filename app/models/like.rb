class Like < ActiveRecord::Base
	belongs_to :drink
 	belongs_to :subscription
end
