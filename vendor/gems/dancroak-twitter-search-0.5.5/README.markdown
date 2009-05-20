# A Twitter Search client for Ruby.

Access the Twitter Search API from your Ruby code.

## Usage

Install the gem.

    sudo gem install dancroak-twitter-search -s http://gems.github.com

Require the gem.

    require 'twitter_search'

Set up a TwitterSearch::Client. Name your client (a.k.a. 'user agent') to something meaningful, such as your app's name. This helps Twitter Search answer any questions about your use of the API.

    @client = TwitterSearch::Client.new 'politweets'

### Search

Request tweets by calling the query method of your client. It takes either a String or a Hash of arguments.

    @tweets = @client.query 'twitter search'

The String form uses the default Twitter Search behavior, which in this example finds tweets containing both "twitter" and "search". It is identical to the more verbose, explicit version:

    @tweets = @client.query :q => 'twitter search'

Use the Twitter Search API's query operators with the :q key to access a variety of behavior.

### Trends

Request the current trending topics by calling the trends method of your client. It takes an optional Hash of arguments.

    @trends = @client.trends

The only supported option currently is exclude_hashtags to return trends that are not hashtags only.

    @trends = @client.trends :exclude_hashtags => true

## Search Operators

The following operator examples find tweets...

* <a href="http://search.twitter.com/search?q=twitter+search">:q => 'twitter search'</a> - containing both "twitter" and "search". This is the default operator. 
* <a href="http://search.twitter.com/search?q=%22happy+hour%22">:q => '<b>"</b>happy hour<b>"</b>'</a> - containing the exact phrase "happy hour".
* <a href="http://search.twitter.com/search?q=obama+OR+hillary">:q => 'obama <b>OR</b> hillary'</a> - containing either "obama" or "hillary" (or both).
* <a href="http://search.twitter.com/search?q=beer+-root">:q => 'beer <b>-</b>root'</a> - containing "beer" but not "root".
* <a href="http://search.twitter.com/search?q=%23haiku">:q => '<b>#</b>haiku</a>' - containing the hashtag "haiku".
* <a href="http://search.twitter.com/search?q=from%3Aalexiskold">:q => '<b>from:</b>alexiskold'</a> - sent from person "alexiskold".
* <a href="http://search.twitter.com/search?q=to%3Atechcrunch">:q => '<b>to:</b>techcrunch</a>' - sent to person "techcrunch".
* <a href="http://search.twitter.com/search?q=%40mashable">:q => '<b>@</b>mashable</a>' - referencing person "mashable".
* <a href="http://search.twitter.com/search?q=superhero+since%3A2008-05-01">:q => 'superhero <b>since:</b>2008-05-01'</a> - containing "superhero" and sent since date "2008-05-01" (year-month-day).
* <a href="http://search.twitter.com/search?q=ftw+until%3A2008-05-03">:q => 'ftw <b>until:</b>2008-05-03'</a> - containing "ftw" and sent up to date "2008-05-03".
* <a href="http://search.twitter.com/search?q=movie+-scary+%3A%29">:q => 'movie -scary <b>:)</b>'</a> - containing "movie", but not "scary", and with a positive attitude.
* <a href="http://search.twitter.com/search?q=flight+%3A%28">:q => 'flight <b>:(</b>'</a> - containing "flight" and with a negative attitude.
* <a href="http://search.twitter.com/search?q=traffic+%3F">:q => 'traffic <b>?</b>'</a> - containing "traffic" and asking a question.
* <a href="http://search.twitter.com/search?q=hilarious+filter%3Alinks">:q => 'hilarious <b>filter:links</b>'</a> - containing "hilarious" and linking to URLs.

### Foreign Languages

The Twitter Search API supports foreign languages, accessible via the :lang key. Use the [ISO 639-1](http://en.wikipedia.org/wiki/ISO_639-1) codes as the value:

    @tweets = @client.query :q => 'programmé', :lang => 'fr'

### Pagination

Alter the number of Tweets returned per page with the :rpp key. Stick with 10, 15, 20, 25, 30, or 50.

    @tweets = @client.query :q => 'Boston Celtics', :rpp => '30'

## Gotchas

* Searches are case-insenstive.
* The "near" operator available in the Twitter Search web interface is not available via the API. You must geocode before making your Twitter Search API call, and use the :geocode key in your request using the pattern lat,lngmi or lat,lngkm:

        @tweets = @client.query :q => 'Pearl Jam', :geocode => '43.4411,-70.9846mi'

* Searching for a positive attitude :) returns tweets containing the text :), =), :D, and :-)

## Contributors

Dustin Sallings, Dan Croak, Luke Francl, Matt Sanford, Alejandro Crosa, Danny Burkes, Don Brown, & HotFusionMan.

## Resources

* [Official Twitter Search API](http://apiwiki.twitter.com/Twitter-API-Documentation)

## License

MIT License, same terms as Ruby.
