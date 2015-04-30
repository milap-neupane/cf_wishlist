class Tracker < ActiveRecord::Base
	belongs_to :user
	belongs_to :wish_list
end
