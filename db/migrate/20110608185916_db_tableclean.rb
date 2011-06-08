class DbTableclean < ActiveRecord::Migration
  def self.up
  	remove_column :orders, :design_id
  	remove_column :designs, :user_id
  end

  def self.down
  end
end
