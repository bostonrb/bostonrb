class TimeOffset < ActiveRecord::Migration
  def change
    add_column :presentations, :video_offset, :string
  end
end
