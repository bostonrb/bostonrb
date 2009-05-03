class DropCommits < ActiveRecord::Migration
  def self.up
    remove_column :commits
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
