require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "limited scope" do

  before do
    uses_fixture(:article)
  end

  it "should default to a limited of 10" do
    Article.limited.proxy_options.should == {:limit => 10}
  end
  
  it "should allow the limited to be specified at runtime" do
    Article.limited(20).proxy_options.should == {:limit => 20}
  end
  
  it "should find the per_page value from will_paginate" do
    ActiveRecord::Base.instance_eval { def per_page; 50; end }
    Article.limited.proxy_options.should == {:limit => 50}
  end
  
  it "should use the runtime limited value over the per_page value from will_paginate" do
    ActiveRecord::Base.instance_eval { def per_page; 50; end }
    Article.limited(5).proxy_options.should == {:limit => 5}
  end
  
  it "should allow override the default limited value with 'default_limited'" do
    Article.default_limit 13
    Article.limited.proxy_options.should == {:limit => 13}
  end
  
  it "should use the runtime value over the default limited value set with 'default_limited'" do
    Article.default_limit 13
    Article.limited(25).proxy_options.should == {:limit => 25}
  end
end