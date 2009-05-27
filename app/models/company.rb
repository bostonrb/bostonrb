class Company < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_url_format_of :website_url,
    :allow_blank => false,
    :message     => "is invalid"

  has_one :feed, :as => :feed_owner, :dependent => :destroy
  accepts_nested_attributes_for :feed, :reject_if => proc { |attrs| attrs.nil? || attrs.all? { |key, value| value.blank? } }

  def to_s
    name
  end
end
