require File.dirname(__FILE__) + '/test_helper'

class PostTest < Test::Unit::TestCase
  should_have_markup :content, :required => true, :syntax => :markdown, :cache_html => true
  
  context 'A new project without content' do
    setup do
      @post = Post.new
    end
    
    context "caching the content, when it's blank" do
      setup do
        @post.set_cached_content_html
      end

      should "not have cached html" do
        assert_nil @post.cached_content_html
      end
    end
    
    context "updating the content" do
      setup do
        @post.update_attributes(:content => 'hi')
      end

      should "now have cached html" do
        assert_equal '<p>hi</p>', @post.cached_content_html
      end
    end
    
  end
end