class AddOrderidToDesign < ActiveRecord::Migration
  def self.up
  	add_column :designs, :order_id, :integer
  end

  def self.down
  	remove_column :designs, :order_id
  end
end
