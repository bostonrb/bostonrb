class ChangeFeedToBelongToFeedOwner < ActiveRecord::Migration
  def self.up
    add_column :feeds, :feed_owner_type, :string
    update %Q{UPDATE feeds SET feed_owner_type = 'User'}
    rename_column :feeds, :user_id, :feed_owner_id
  end

  def self.down
    raise ActiveRecord::IrreversableMigration
  end
end
