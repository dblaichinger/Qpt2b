class AddXmldataToDesign < ActiveRecord::Migration
  def self.up
  	add_column :designs, :xml_data, :text
  end

  def self.down
  	remove_column :designs, :xml_data
  end
end
