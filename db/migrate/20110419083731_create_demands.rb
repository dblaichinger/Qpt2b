class CreateDemands < ActiveRecord::Migration
  def self.up
    create_table :demands do |t|
      t.integer :counter
      t.float :longitude
      t.float :latitude
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :demands
  end
end
