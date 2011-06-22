class Presenter < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_many :presentations
  validates :name, :presence => true

  def self.group_by_score
    all.inject(Hash.new { |hash, key| hash[key] = [] }) do |collection, presenter|
      presentations_count = presenter.presentations.count
      sorted_presenters   = (collection[presentations_count] << presenter).sort_by(&:name)
      collection.merge!(presentations_count => sorted_presenters)
    end
  end
end
