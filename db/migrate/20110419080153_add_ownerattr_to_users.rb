class AddOwnerattrToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :name, :string
  	add_column :users, :street, :string
  	add_column :users, :city, :string
  	add_column :users, :token, :string
  end

  def self.down
  	remove_column :users, :name
  	remove_column :users, :street
  	remove_column :users, :city
  	remove_column :users, :token
  end
end
