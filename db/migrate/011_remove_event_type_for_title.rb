class RemoveEventTypeForTitle < ActiveRecord::Migration
  def self.up
    add_column :events, :title, :string
    
    # FIXME use update stuff instead
    Event.find(:all).each do |event|
      event[:title] = event[:event_type]
      event.save!
    end
    
    remove_column :events, :event_type
  end

  def self.down
    add_column :events, :event_type
    
    # FIXME use update stuff instead
    Event.find(:all).each do |event|
      # hackfests... EVERYTIME!
      # TODO maybe guess based on regex?
      event[:event_type] = 'Hackfest'
    end
    
    remove_column :events, :event_type
  end
end
