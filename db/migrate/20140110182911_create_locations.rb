class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name, null: false, unique: true
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
