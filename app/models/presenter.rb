class Presenter < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_many :presentations
  validates :name, :presence => true

  def self.group_by_score
    group = all.inject(Hash.new { |hash, key| hash[key] = [] }) do |collection, presenter|
      presentations_count = presenter.presentations.past_or_by_month.count
      sorted_presenters   = (collection[presentations_count] << presenter).sort_by(&:name)
      collection.merge!(presentations_count => sorted_presenters)
    end
    group.delete(0)
    group
  end
end
