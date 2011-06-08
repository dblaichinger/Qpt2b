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
	has_one :trashcan, :foreign_key => "trashcan_id"
	has_one :design, :dependent => :destroy

	accepts_nested_attributes_for :design

	#validates :code, :presence => true
	#validates :owner_id, :presence => true
end
