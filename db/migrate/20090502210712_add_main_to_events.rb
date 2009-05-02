class AddMainToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :main, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :events, :main
  end
end
