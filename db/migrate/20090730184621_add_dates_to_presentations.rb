class AddDatesToPresentations < ActiveRecord::Migration
  def self.up
    add_column :presentations, :date_of, :datetime
  end

  def self.down
    remove_column :presentations, :date_of
  end
end
