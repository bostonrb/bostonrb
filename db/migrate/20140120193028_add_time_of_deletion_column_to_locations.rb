class AddTimeOfDeletionColumnToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :time_of_deletion, :timestamp
  end
end
