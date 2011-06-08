class AddStatustoOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :status, :integer, :default => 0
  end

  def self.down
    remove_column :orders, :status
  end
end
