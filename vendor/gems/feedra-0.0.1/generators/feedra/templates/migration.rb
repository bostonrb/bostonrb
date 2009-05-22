class CreateFeedAndEvents < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.string :etag
      t.time :last_modified_at
      t.string :feed_url
      t.time :stale_at

      t.timestamps
    end

    create_table :feed_errors do |t|
      t.string     :error_type
      t.string     :message
      t.text       :trace
      t.references :feed

      t.timestamps
    end

    create_table :entries do |t|
      t.string :title
      t.string :author
      t.string :url
      t.text :summary
      t.text :content
      t.datetime :published_at
      t.text :categories
      t.string :checksum
      t.references :feed

      t.timestamps
    end

  end
 
  def self.down
    drop_table :feeds
    drop_table :feed_errors
    drop_table :entries
  end
end

