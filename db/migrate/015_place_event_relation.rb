class PlaceEventRelation < ActiveRecord::Migration
  def self.up
    add_column :events, :place_id, :integer
  end

  def self.down
    remove_column :events, :place_id
  end
end
