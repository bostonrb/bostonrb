require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  context "an project" do
    setup do
      @project = Factory(:project, :name => "Paperclip")
    end

    subject { @project }

    should_validate_presence_of :name, :user_id
    should_validate_url_format_of :github_url

    should "display name as string representation" do
      assert_equal "Paperclip", @project.to_s
    end
  end
end
