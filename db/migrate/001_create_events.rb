class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :event_type
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
