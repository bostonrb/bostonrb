class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :author
      t.string :twitter_username
      t.string :url
      t.string :feed_url
      t.string :etag
      t.string :most_recent_post_url

      t.timestamps
    end
  end
end
