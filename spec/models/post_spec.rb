require 'spec_helper'

describe Post do
  before do
    brian_blog.stubs(:load_from_feed)
    brian_blog.stubs(:follow_on_twitter)
    brian_blog.stubs(:tweet_new_blogger)
  end
  let(:brian_blog) { Factory.build :blogger, name: "Brian Cardarella", title: "Brian's Blog", twitter_username: "@brian", url: "http://bcardarella.com/"}
  describe 'Delegations' do
    subject { Factory :post, blogger:  brian_blog }
    its(:blogger_name            ) { should == 'Brian Cardarella'       }
    its(:blogger_title           ) { should == "Brian's Blog"           }
    its(:blogger_twitter_username) { should == "@brian"                 }
    its(:blogger_url             ) { should == "http://bcardarella.com/"}
  end

  describe '.most_recent' do
    let!(:fairly_recent_post) { Factory :post, blogger:  brian_blog, published_at: 1.week.ago   }
    let!(:ancient_post)       { Factory :post, blogger:  brian_blog, published_at: 1.year.ago   }
    let!(:current_post)       { Factory :post, blogger:  brian_blog, published_at: 1.minute.ago }
    describe 'the 2 most recent' do
      subject { Post.most_recent(page: 1, per: 2) }
      it { should == [current_post, fairly_recent_post] }
    end
    describe 'paginating to older ones' do
      subject { Post.most_recent(page: 2, per: 2) }
      it { should == [ancient_post] }
    end
  end

  describe '.new_from_entries' do
    let(:entry) { Feedzirra::Parser::AtomEntry.new }
    before do
      entry.title      = 'A new Post'
      entry.url        = 'http://blog.com/a-new-post'
      entry.summary    = 'about something'
      entry.published  = 1.day.ago.to_s
      entry.entry_id   = 'http://blog.com/a-new-post'
      entry.categories = ['Ruby', 'Rails']
    end
    let(:posts) { Post.new_from_entries brian_blog, [entry] }
    subject { posts }
    its(:size) { should == 1 }
    describe 'the post' do
      subject { posts.first }
      its(:blogger     ) { should == brian_blog                                                      }
      its(:title       ) { should == 'A new Post'                                                    }
      its(:url         ) { should == 'http://blog.com/a-new-post'                                    }
      its(:summary     ) { should == 'about something'                                               }
      its(:published_at) { should == entry.published                                                 }
      its(:guid        ) { should == 'http://blog.com/a-new-post'                                    }
      its(:categories  ) { should == [Category.find_by_name('Ruby'), Category.find_by_name('Rails')] }
    end
  end

  describe '#category_names' do
    let(:ruby_category ) { Factory :category, name: 'Ruby' }
    let(:rails_category) { Factory :category, name: 'Rails' }
    subject { Factory :post, blogger:  brian_blog, categories: [ruby_category, rails_category] }
    its(:category_names) { should == ['Ruby', 'Rails'] }
  end

  describe '#default_tweet_message' do
    let(:post) { Factory.build :post, blogger: brian_blog, url: 'http://bcardarella.com/my-new-post' }
    subject { post }

    describe 'with a short title that fits' do
      before { post.title = 'Something Short and Sweet' }
      its(:default_tweet_message) { should == 'Boston Rubyist @brian blogs about Something Short and Sweet http://bcardarella.com/my-new-post'}
    end
    describe 'when a long title must be truncated' do
      before { post.title = 'This Title Goes On And On For Way Too Long. Why Can I Not Be More Concise? This Will Not Fit In A Tweet :(' }
      its(:default_tweet_message) { should == 'Boston Rubyist @brian blogs about This Title Goes On And On For Way Too Long. Why Can I Not Be More Concise? This Wi... http://bcardarella.com/my-new-post'}
    end
  end

  describe '#tweet' do
    let(:post) { Factory.build :post, blogger: brian_blog, url: 'http://bcardarella.com/my-new-post', title: 'Something Short and Sweet' }
    it 'tweets with the default message' do
      Twitter.expects(:update).with('Boston Rubyist @brian blogs about Something Short and Sweet http://bcardarella.com/my-new-post')
      post.tweet
    end
    it 'tweets with a custom message' do
      Twitter.expects(:update).with('check out @brian and http://bcardarella.com/my-new-post')
      post.tweet 'check out @brian and http://bcardarella.com/my-new-post'
    end
  end
end
