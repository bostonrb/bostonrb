class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blogger
      t.string     :title
      t.text       :summary
      t.string     :url
      t.string     :guid
      t.datetime   :published_at

      t.timestamps
    end
    add_index :posts, :published_at
  end
end
