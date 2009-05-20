class DropPlaces < ActiveRecord::Migration
  def self.up
    drop_table :places
  end

  def self.down
    create_table "places", :force => true do |t|
      t.string   "name"
      t.string   "address"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
