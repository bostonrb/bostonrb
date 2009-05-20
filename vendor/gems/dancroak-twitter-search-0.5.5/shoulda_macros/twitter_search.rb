module TwitterSearch
  module Shoulda
    def should_have_default_search_behaviors
      should_find_tweets
      should_have_text_for_all_tweets
      should_return_page 1
      should_return_tweets_in_sets_of 15
    end

    def should_find_tweets
      should 'find tweets' do
        assert @tweets.any?
      end
    end

    def should_have_text_for_all_tweets
      should 'have text for all tweets' do
        assert @tweets.all? { |tweet| tweet.text.size > 0 }
      end
    end

    def should_return_page(number)
      should "return page #{number}" do
        assert_equal number, @tweets.page
      end
    end

    def should_return_tweets_in_sets_of(number)
      should "return tweets in sets of #{number}" do
        assert_equal number, @tweets.results_per_page
      end
    end
  end
end

Test::Unit::TestCase.extend(TwitterSearch::Shoulda)
