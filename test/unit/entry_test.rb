require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  should "include Feedra::Entry" do
    assert Entry.included_modules.include?(Feedra::Entry)
  end

  context "recent" do

    setup do
      @expected = stub('entries')

      Entry.stub_chain(:limited, :by_published_at, :by_created_at).returns(@expected)
      @actual = Entry.recent(5)
    end

    should "return the entries" do
      assert_equal @expected, @actual
    end

    should "get 5 entries" do
      assert_received(Entry, :limited) {|subject| subject.with(5) }
    end

    should "sort by published_at, descending" do
      assert_received(Entry, :by_published_at) {|subject| subject.with(:desc) }
    end

    should "sort by created_at, descending" do
      assert_received(Entry, :by_created_at) {|subject| subject.with(:desc) }
    end

  end
end
