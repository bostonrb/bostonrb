class VideoAttrsForPresentations < ActiveRecord::Migration
  def self.up
    add_column :presentations, :video_provider, :string
    t = Presentation.arel_table
    Presentation.where(t[:vimeo_id].not_eq(nil)).each do |presentation|
      presentation.update_attribute(:video_provider, 'vimeo')
    end
    rename_column :presentations, :vimeo_id, :video_id
  end

  def self.down
    rename_column :presentations, :video_id, :vimeo_id
    remove_column :presentations, :video_provider
  end
end
