require File.dirname(__FILE__) + '/../test_helper'

class PresentationTest < ActiveSupport::TestCase
  context "an presentation" do
    setup do
      @presentation = Factory(:presentation, :title => "Agile Design")
    end

    subject { @presentation }

    should_belong_to :user

    should "display name as string representation" do
      assert_equal "Agile Design", @presentation.to_s
    end
  end
end
