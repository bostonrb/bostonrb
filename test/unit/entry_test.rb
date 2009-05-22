require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  should "include Feedra::Entry" do
    assert Entry.included_modules.include?(Feedra::Entry)
  end

  should_have_named_scope 'recent(5)', :order => 'published_at desc, created_at desc', :limit => 5
end
