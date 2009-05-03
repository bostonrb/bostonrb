class RenameVideosPresentations < ActiveRecord::Migration
  def self.up
    rename_table :videos, :presentations
  end

  def self.down
    rename_table :presentations, :videos
  end
end
