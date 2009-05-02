require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_have_many :commits
  should_have_markup :description, :cache_html => true
end
