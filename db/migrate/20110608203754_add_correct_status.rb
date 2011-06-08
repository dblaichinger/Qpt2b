class AddCorrectStatus < ActiveRecord::Migration
  def self.up
    change_column :orders, :status, :string, :default => "pending"
  end

  def self.down
  end
end
