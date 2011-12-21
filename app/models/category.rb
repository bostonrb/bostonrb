class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  validates :name, :presence => true

  def self.find_or_create_many_by_name(category_names)
    return [] if category_names.nil?
    category_names.map do |category_name|
      find_or_create_by_name(category_name)
    end
  end
end
