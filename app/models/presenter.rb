class Presenter < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_many :presentation_presenters
  has_many :presentations, :through => :presentation_presenters
  validates :name, :presence => true

  def self.group_by_score
    groups = all.group_by { |p| p.presentations.past_or_by_month.count }
    groups.tap do |g|
      g.delete(0)
      g.values.each { |presenters| presenters.sort_by!(&:name) }
    end
  end
end
