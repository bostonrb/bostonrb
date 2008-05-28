class CreateCommits < ActiveRecord::Migration
  def self.up
    create_table :commits do |t|
      t.string :title
      t.string :url
      t.datetime :published_at
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :commits
  end
end
