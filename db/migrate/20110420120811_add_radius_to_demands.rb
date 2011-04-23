class AddRadiusToDemands < ActiveRecord::Migration
  def self.up
    add_column :demands, :radius, :int
  end

  def self.down
    remove_column :demands, :radius, :int
  end
end
