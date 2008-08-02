class Post < ActiveRecord::Base
  has_markup :content, :required => true, :syntax => :markdown, :cache_html => true
end