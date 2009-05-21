class AddUserIdAndGuestSpeakersToPresentations < ActiveRecord::Migration
  def self.up
    remove_column :presentations, :presenter
    add_column :presentations, :user_id, :integer, :null => true
    add_column :presentations, :other_speakers, :string

    add_index :presentations, :user_id
  end

  def self.down
    remove_column :presentations, :other_speakers
    remove_column :presentations, :user_id
    add_column :presentations, :presenter, :string
  end
end
