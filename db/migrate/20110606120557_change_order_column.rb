class ChangeOrderColumn < ActiveRecord::Migration
  def self.up
  	rename_column :orders, :owner_id, :user_id
  end

  def self.down
  	rename_column :orders, :user_id, :owner_id
  end
end
