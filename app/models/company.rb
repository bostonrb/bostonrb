class Company < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_url_format_of :website_url,
    :allow_blank => false,
    :message     => "is invalid"

  def to_s
    name
  end
end
