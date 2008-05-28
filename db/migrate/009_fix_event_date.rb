class FixEventDate < ActiveRecord::Migration
  def self.up
    change_column :events, :date, :datetime
  end

  def self.down
    change_column :events, :date, :date
  end
end
