class RemoveGigBooleanFromJobs < ActiveRecord::Migration
  def self.up
    remove_column :jobs, :gig
  end

  def self.down
    add_column :jobs, :gig, :boolean
  end
end
