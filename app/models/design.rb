class Design < ActiveRecord::Base
	attr_accessible :user_id, :order_id, :image_path, :xml_data

	belongs_to :order
end
