class CreateBloggers < ActiveRecord::Migration
  def change
    create_table :bloggers do |t|
      t.string :name
      t.string :title
      t.string :twitter_username
      t.string :url
      t.string :feed_url
      t.string :etag

      t.timestamps
    end
    add_index :bloggers, :name
  end
end
