class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |table|
      table.string :text
      table.integer :twitter_id
      table.belongs_to :user
      table.timestamps
    end

    add_index :tweets, :user_id
  end

  def self.down
    remove_index :tweets, :user_id
    drop_table :tweets
  end
end
