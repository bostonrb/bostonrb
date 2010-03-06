class AddEventSummary < ActiveRecord::Migration
  def self.up
    add_column :events, :summary, :text
    add_column :events, :cached_summary_html, :text
  end

  def self.down
    remove_column :events, :cached_summary_html
    remove_column :events, :summary
  end
end
