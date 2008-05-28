class RemoveNameFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :name
  end

  def self.down
    add_column :events, :name, :string
  end
end
