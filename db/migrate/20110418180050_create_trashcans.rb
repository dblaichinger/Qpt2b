class CreateTrashcans < ActiveRecord::Migration
  def self.up
    create_table :trashcans do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :is_free
      t.date :adopted_until

      t.timestamps
    end
  end

  def self.down
    drop_table :trashcans
  end
end
