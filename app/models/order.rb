class Order < ActiveRecord::Base

	attr_accessible :owner_id, :trashcan_id, :design_id, :code

	belongs_to :user
	belongs_to :trashcan
	has_one :design
end