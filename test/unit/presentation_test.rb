require File.dirname(__FILE__) + '/../test_helper'

class PresentationTest < ActiveSupport::TestCase
  context 'A presentation' do
    should_have_class_methods :all

  end
end
