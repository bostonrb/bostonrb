require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_have_markup :description, :cache_html => true
  should_validate_url_format_of :homepage_url
end
