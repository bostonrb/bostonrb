require File.dirname(__FILE__) + '/test_helper'

class PostTest < Test::Unit::TestCase
  should_have_markup :content, :required => true, :syntax => :markdown, :cache_html => true
  
  context 'A new project without content' do
    setup do
      @post = Post.new
    end
    
    should 'not cache anything doing cache_content' do
      @post.cache_content_html
      assert_nil @post.cached_content_html
    end
  end
end