require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FeedError do
  describe "create_from_feedzirra_error" do
    it "should work from a Fixnum" do
      expected_attributes = {:error_type => "Fixnum", :message => "404"}

      mock(FeedError).create(expected_attributes)

      FeedError.create_from_feedzirra_error(404)
    end
    
    it "should work from nil" do
      expected_attributes = {:error_type => "NilClass", :message => "nil"}

      mock(FeedError).create(expected_attributes)

      FeedError.create_from_feedzirra_error(nil)
    end

    it "should work from an RuntimeError or otherwise" do
      expected_attributes = {:error_type => "RuntimeError", :message => "zomg", :backtrace => "somebacktrace"}

      mock(FeedError).create(expected_attributes)

      feedzirra_error = RuntimeError.new
      stub(feedzirra_error).backtrace { "somebacktrace" }
      stub(feedzirra_error).message { "zomg" }
      FeedError.create_from_feedzirra_error(feedzirra_error)
    end

  end
end
