require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Eager scope" do

  before do
    uses_fixture(:article)
  end
  
  it "should provide eager loading of a single association" do
    Article.with(:comments).proxy_options.should == {:include => [:comments] }
  end

  it "should provide eager loading of a multiple associations" do
    Article.with(:comments, :contributors).proxy_options.should == {:include => [:comments, :contributors] }
  end
  
  it "should provider eager loading of nested associations" do
    Article.with(:comments => :author).proxy_options.should == {:include => [ {:comments => :author} ] }
  end
end