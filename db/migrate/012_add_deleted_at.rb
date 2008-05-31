class AddDeletedAt < ActiveRecord::Migration
  def self.up
    %w(events jobs projects videos).each do |table|
      add_column table, :deleted_at, :datetime
    end
  end

  def self.down
    %w(events jobs projects videos).each do |table|
      remove_column table, :deleted_at
    end
  end
end
