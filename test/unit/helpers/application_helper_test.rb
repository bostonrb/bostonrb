require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  context 'ApplicationHelper#blueprint_ie' do
    setup do
      @result = blueprint_ie
    end

    should 'not be nil' do
      assert_not_nil @result
    end

    should 'do magic ie comment to only load in IE' do
      expected = %q(<!--[if IE]>)
      assert @result.include?(expected)
    end
  end
end
