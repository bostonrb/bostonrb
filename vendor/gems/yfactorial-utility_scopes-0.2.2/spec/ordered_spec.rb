require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Ordered scope" do

  before(:each) do
    uses_fixture(:article)
  end

  it "should default to created_at DESC" do
    Article.ordered.proxy_options.should == {:order => 'created_at DESC'}
    Article.default_ordering.should == 'created_at DESC'
  end
  
  it "should allow the order to be specified at runtime" do
    Article.ordered('created_at ASC').proxy_options.should == {:order => 'created_at ASC'}
  end
  
  it "should allow the order to use arrays as arg" do
    Article.ordered([:popularity, :asc], [:second_param, :desc]).proxy_options.should == {:order => 'popularity ASC, second_param DESC'}
  end
  
  it "should allow the order hash as arg" do
    if (PLATFORM=~/java/ || RUBY_VERSION=~/1\.9.*/)
      Article.ordered(:popularity => :asc, :second_param => :desc).proxy_options.should == {:order => 'popularity ASC, second_param DESC'}
    end
  end
  
  it "should allow the order with several args" do
    Article.ordered(:popularity, :updated_at).proxy_options.should == {:order => 'popularity, updated_at'}
  end

  it "should sort by column popularity when calling order_by_popularity" do
    require 'ostruct'
    columns = [OpenStruct.new({:name => 'popularity'})]
    Article.stub!(:columns).and_return(columns)
    Article.order_by_popularity.proxy_options.should == {:order => 'popularity'}
  end
  
  it "should raise an error when column does not exist" do
    require 'ostruct'
    columns = [OpenStruct.new({:name => 'popularity'})]
    Article.stub!(:columns).and_return(columns)
    lambda{ Article.order_by_unknown_columns }.should raise_error
  end
  
  it "should have an alias" do
    Article.order_by([:popularity, :asc]).proxy_options.should == {:order => 'popularity ASC'}
  end
  
  it "should allow the default to be overidden by using ordered_by" do
    Article.ordered_by 'published_at DESC'
    Article.default_ordering.should == 'published_at DESC'
    Article.ordered.proxy_options.should == {:order => 'published_at DESC'}
  end
  
  it "should use the runtime sort value over the ordered_by value" do
    Article.ordered_by 'published_at DESC'
    Article.ordered('popularity ASC').proxy_options.should == {:order => 'popularity ASC'}
  end
  
  it "should be able to handle symbol order criteria" do
    Article.ordered(:id).proxy_options.should == { :order => 'id' }
  end
end