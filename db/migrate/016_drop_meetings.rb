class DropMeetings < ActiveRecord::Migration
  def self.up
    drop_table :meetings
  end

  def self.down
    create_table :meetings do |t|
    end
  end
end
