require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  context "tab_link_attributes" do
    should "give me an attributes hash set with 'current'" do
      expected_hash = {:class => 'current'}
      assert_equal expected_hash, tab_link_attributes("current_test_controller")
    end
    
    should "give me an empty attributes hash" do
      expected_hash = {}
      assert_equal expected_hash, tab_link_attributes("not_current_test_controller")
    end
  end
  
  context "sentence_of" do
    
    should "take an array and join with 'or's" do
      assert_equal "1, 2, 3, 4, or 5", sentence_of(%w{1 2 3 4 5}, :connector => :or)
      assert_equal "123 or 456", sentence_of([%w{1 2 3},%w{4 5 6}], :connector => :or)
    end
  
    should "default to %w{1 2 3 4 5}.to_sentence" do
      assert_equal %w{1 2 3 4 5}.to_sentence, sentence_of(%w{1 2 3 4 5})
    end
  end
  
  def controller
    unless @test_controler
      @test_controller = Object.new
      @test_controller.stubs(:controller_name).returns("current_test_controller")
    end
    @test_controller
  end
end
