require File.dirname(__FILE__) + '/../test_helper'

class CommitTest < ActiveSupport::TestCase
  
  should_belong_to :project
  
end
