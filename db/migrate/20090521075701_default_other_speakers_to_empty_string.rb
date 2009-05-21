class DefaultOtherSpeakersToEmptyString < ActiveRecord::Migration
  def self.up
    change_column_default :presentations, :other_speakers, ""
  end

  def self.down
  end
end
