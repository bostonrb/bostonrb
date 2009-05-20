require File.dirname(__FILE__) + '/../test_helper'

class PresentationTest < ActiveSupport::TestCase
  context 'A presentation' do
    should_have_class_methods :all
    should_have_db_columns :title, :url, :embed, :presenter, :source

    context 'populating the embed field from a good url' do
      setup do
        @presentation = Factory.build(:presentation)
        @presentation.stubs(:open).with(@presentation.url).returns(file_fixture('google_video.html'))
        @presentation.populate_embed
      end

      should 'have non-nil embed property' do
        assert_not_nil @presentation.embed
      end

      should 'not have errors' do
        assert @presentation.errors.empty?
      end
    end

    context 'populate the embed field from a bad url' do
      setup do
        @presentation = Factory.build(:presentation)
        @presentation.stubs(:open).with("bad url").raises
        @presentation.populate_embed
      end

      should 'have errors' do
        assert ! @presentation.errors.empty?
      end
    end
  end
end
