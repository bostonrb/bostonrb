class BigTwitterIds < ActiveRecord::Migration
  def self.up
    change_column :tweets, :twitter_id, :integer, :limit => 8
  end

  def self.down
    change_column :tweets, :twitter_id, :integer
  end
end
