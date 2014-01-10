class CreateEventTypes < ActiveRecord::Migration
  def up
    create_table :event_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end

  def down
    drop_table :event_types
  end
end
