class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.belongs_to :location, index: true, null: false
      t.belongs_to :event_type, index: true, null: false
      t.string :date, null: false
      t.string :start_at, null: false
      t.string :end_at, null: false
      t.string :rsvp_url, null: false

      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
