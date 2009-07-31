require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  context "sentence_of" do
    should "take an array and join with 'or's" do
      assert_equal "1, 2, 3, 4, or 5", sentence_of(%w{1 2 3 4 5}, :connector => :or)
      assert_equal "123 or 456", sentence_of(%w{123 456}, :connector => :or)
    end

    should "default to %w{1 2 3 4 5}.to_sentence" do
      assert_equal %w{1 2 3 4 5}.to_sentence, sentence_of(%w{1 2 3 4 5})
    end

    should "pass each item to the yield block, if given" do
      assert_equal %w{A B C D E}.to_sentence, sentence_of(%w{a b c d e}) {|letter| letter.upcase }
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
