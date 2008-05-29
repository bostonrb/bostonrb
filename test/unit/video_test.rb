require File.dirname(__FILE__) + '/../test_helper'

class VideoTest < ActiveSupport::TestCase
  context 'A video' do
    should_have_class_methods :all
    should_have_db_columns :title, :url, :embed, :presenter, :source
    
    context 'populating the embed field from a good url' do
      setup do
        @video = new_video
        @video.stubs(:open).with(@video.url).returns(file_fixture('google_video.html'))
        @video.populate_embed
      end
      
      should 'have non-nil embed property' do
        assert_not_nil @video.embed
      end
      
      should 'not have errors' do
        assert @video.errors.empty?
      end
    end
    
    context 'populate the embed field from a bad url' do
      setup do
        @video = new_video
        # TODO stub with something more realistic
        @video.stubs(:open).with(@video.url).raises
        @video.populate_embed
      end
      
      should 'have errors' do
        assert ! @video.errors.empty?
      end
    end
  end
end
