== Feed Normalizer

An extensible Ruby wrapper for Atom and RSS parsers.

Feed normalizer wraps various RSS and Atom parsers, and returns a single unified
object graph, regardless of the underlying feed format.

== Download

* gem install feed-normalizer
* http://rubyforge.org/projects/feed-normalizer
* svn co http://feed-normalizer.googlecode.com/svn/trunk

== Usage

    require 'feed-normalizer'
    require 'open-uri'

    feed = FeedNormalizer::FeedNormalizer.parse open('http://www.iht.com/rss/frontpage.xml')

    feed.title # => "International Herald Tribune"
    feed.url # => "http://www.iht.com/pages/index.php"
    feed.entries.first.url # => "http://www.iht.com/articles/2006/10/03/frontpage/web.1003UN.php"

    feed.class # => FeedNormalizer::Feed
    feed.parser # => "RSS::Parser"

Now read an Atom feed, and the same class is returned, and the same terminology applies:

    feed = FeedNormalizer::FeedNormalizer.parse open('http://www.atomenabled.org/atom.xml')

    feed.title # => "AtomEnabled.org"
    feed.url # => "http://www.atomenabled.org/atom.xml"
    feed.entries.first.url # => "http://www.atomenabled.org/2006/09/moving-toward-atom.php"

The feed representation stays the same, even though a different parser was used.

    feed.class # => FeedNormalizer::Feed
    feed.parser # => "SimpleRSS"

== Cleaning / Sanitizing

    feed.title # => "My Feed > Your Feed"
    feed.entries.first.content # => "<p x='y'>Hello</p><object></object></html>"
    feed.clean!

All elements should now be either clean HTML, or HTML escaped strings.

    feed.title # => "My Feed &gt; Your Feed"
    feed.entries.first.content # => "<p>Hello</p>"

== Extending

Implement a parser wrapper by extending the FeedNormalizer::Parser class and overriding
the public methods. Also note the helper methods in the root Parser object to make
mapping of output from the particular parser to the Feed object easier.

See FeedNormalizer::RubyRssParser and FeedNormalizer::SimpleRssParser for examples.

== Authors
* Andrew A. Smith (andy@tinnedfruit.org)

This library is released under the terms of the BSD License (see the License.txt file for details).
