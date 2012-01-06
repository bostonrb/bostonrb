require 'spec_helper'

describe FakeTwitter do
  before do
    FakeTwitter.activate!
  end

  describe '.follow' do
    it 'should remember who we start following' do
      Twitter.follow 'brian'
      Twitter.follow 'alex'
      Twitter.fake_following.should == ['brian', 'alex']
    end
  end

  describe '.update' do
    it 'should remember our tweets' do
      Twitter.update '@bostonrb meeting starting'
      Twitter.update '@bostonrb meeting just ended'
      Twitter.fake_tweets.should == ['@bostonrb meeting starting', '@bostonrb meeting just ended']
    end
  end

end
