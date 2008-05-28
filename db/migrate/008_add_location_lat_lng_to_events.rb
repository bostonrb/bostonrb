class AddLocationLatLngToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :location, :string
    add_column :events, :lng, :float
    add_column :events, :lat, :float
  end

  def self.down
    remove_column :events, :location
    remove_column :events, :lng
    remove_column :events, :lat
  end 
end