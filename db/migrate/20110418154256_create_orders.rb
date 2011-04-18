class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :trashcan_id
      t.integer :owner_id
      t.string  :code
      t.integer :design_id
      t.string  :name

      t.timestamps
    end
    add_index :orders, :owner_id
    add_index :orders, :design_id
    add_index :orders, :trashcan_id
  end

  def self.down
    drop_table :orders
  end
end
