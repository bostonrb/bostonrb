require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  context "an project" do
    setup do
      @project = Factory(:project, :name => "Paperclip")
    end

    should_have_markup :description, :cache_html => true
    should_validate_url_format_of :homepage_url

    should "display name as string representation" do
      assert_equal "Paperclip", @project.to_s
    end
  end
end
