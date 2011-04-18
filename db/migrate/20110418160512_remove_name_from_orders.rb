class RemoveNameFromOrders < ActiveRecord::Migration
  def self.up
  	remove_column :orders, :name
  end

  def self.down
  end
end
