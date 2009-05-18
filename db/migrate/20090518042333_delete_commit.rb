class DeleteCommit < ActiveRecord::Migration
  def self.up
    drop_table "commits"
  end

  def self.down
    create_table "commits", :force => true do |t|
      t.string   "title"
      t.string   "url"
      t.datetime "published_at"
      t.integer  "project_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
