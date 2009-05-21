class Company < ActiveRecord::Base
  validates_uniqueness_of :name, :allow_blank => false
  validates_url_format_of :website_url,
    :allow_blank => false,
    :message     => "is invalid"

  def to_s
    name
  end
end
