class Design < ActiveRecord::Base
	attr_accessible :user_id, :order_id, :image_path

	belongs_to :order
	belongs_to :user
end
