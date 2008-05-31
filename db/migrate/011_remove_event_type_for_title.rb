class RemoveEventTypeForTitle < ActiveRecord::Migration
  def self.up
    add_column :events, :title, :string
    
    update "update events set title = event_type"
    
    remove_column :events, :event_type
  end

  def self.down
    add_column :events, :event_type
    
    update "update events set event_type = 'Hackfest'"
    
    remove_column :events, :event_type
  end
end
