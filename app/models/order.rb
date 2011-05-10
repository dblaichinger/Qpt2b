# == Schema Information
# Schema version: 20110419083731
#
# Table name: orders
#
#  id          :integer(4)      not null, primary key
#  trashcan_id :integer(4)
#  owner_id    :integer(4)
#  code        :string(255)
#  design_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Order < ActiveRecord::Base

	attr_accessible :owner_id, :trashcan_id, :design_id, :code

	belongs_to :user, :foreign_key => "owner_id"
	belongs_to :trashcan
	has_one :design

	#validates :code, :presence => true
	validates owner_id, :presence => true
end
