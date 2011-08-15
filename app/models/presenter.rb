class Presenter < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_many :presentation_presenters
  has_many :presentations, :through => :presentation_presenters
  validates :name, :presence => true

  def self.group_by_score
    grouping = all.group_by { |presenter| presenter.presentations.past_or_by_month.count }
    grouping.delete(0)
    grouping.values.each { |presenters| presenters.sort_by!(&:name) }
    grouping
  end
end
