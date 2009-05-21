class AddLocationToPresentations < ActiveRecord::Migration
  def self.up
    add_column :presentations, :location, :string
  end

  def self.down
    remove_column :presentations, :location
  end
end
