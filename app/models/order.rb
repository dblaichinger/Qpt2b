# == Schema Information
# Schema version: 20110419083731
#
# Table name: orders
#
#  id          :integer(4)      not null, primary key
#  trashcan_id :integer(4)
#  user_id     :integer(4)
#  code        :string(255)
#  design_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Order < ActiveRecord::Base

	attr_accessible :user_id, :trashcan_id, :design_id, :code, :design_attributes
	belongs_to :user, :foreign_key => "user_id", :dependent => :destroy
	
	belongs_to :trashcan, :foreign_key => "trashcan_id"
	has_one :design

	accepts_nested_attributes_for :design

	validates :trashcan_id => "value", :presence => true

	def self.random_code
		 return rand(100) + Time.new.to_i
	end

end


