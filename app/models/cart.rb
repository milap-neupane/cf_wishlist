class Cart < ActiveRecord::Base
	belongs_to :user
	has_many :wish_lists
end
