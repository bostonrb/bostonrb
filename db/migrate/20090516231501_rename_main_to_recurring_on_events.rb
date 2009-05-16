class RenameMainToRecurringOnEvents < ActiveRecord::Migration
  def self.up
    rename_column :events, :main, :recurring
  end

  def self.down
    rename_column :events, :recurring, :main
  end
end
