require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Entry do

  describe "find_by_feedzirra_entry" do

    it "should return a entry found by title and url" do
      feedzirra_entry = "feedzirra entry"
      stub(feedzirra_entry).title { "zomg" }
      stub(feedzirra_entry).url { "http://example.com/zomg" }

      entry = "entry"
      mock(Entry).find(:first, :conditions => {:title => "zomg", :url => "http://example.com/zomg"}) { entry }

      Entry.find_by_feedzirra_entry(feedzirra_entry).should == entry
    end

  end

end
