require 'test/unit'
require 'html-cleaner'

include FeedNormalizer

class HtmlCleanerTest < Test::Unit::TestCase

  def test_unescape
    assert_equal "' ' &deg;", FeedNormalizer::HtmlCleaner.unescapeHTML("&apos; &#39; &deg;")
    assert_equal "\" &deg;", FeedNormalizer::HtmlCleaner.unescapeHTML("&quot; &deg;")
    assert_equal "\"\"\"\"", FeedNormalizer::HtmlCleaner.unescapeHTML("&#34;&#000000000000000000034;&#x22;&#x0000022;")
    assert_equal "heavily subnet&#8217;d network,", FeedNormalizer::HtmlCleaner.unescapeHTML("heavily subnet&#8217;d network,")
  end

  def test_add_entities
    assert_equal "", HtmlCleaner.add_entities(nil)
    assert_equal "x &gt; y", HtmlCleaner.add_entities("x > y")
    assert_equal "1 &amp; 2", HtmlCleaner.add_entities("1 & 2")
    assert_equal "&amp; &#123; &acute; &#x123;", HtmlCleaner.add_entities("& &#123; &acute; &#x123;")
    assert_equal "&amp; &#123; &ACUTE; &#X123A; &#x80f;", HtmlCleaner.add_entities("& &#123; &ACUTE; &#X123A; &#x80f;")
    assert_equal "heavily subnet&#8217;d network,", HtmlCleaner.add_entities("heavily subnet&#8217;d network,")
  end

  def test_html_clean
    assert_equal "", HtmlCleaner.clean("")

    assert_equal "<p>foo &gt; *</p>", HtmlCleaner.clean("<p>foo > *</p>")
    assert_equal "<p>foo &gt; *</p>", HtmlCleaner.clean("<p>foo &gt; *</p>")

    assert_equal "<p>para</p>", HtmlCleaner.clean("<p foo=bar>para</p>")
    assert_equal "<p>para</p> outsider", HtmlCleaner.clean("<p foo=bar>para</p> outsider")

    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p></notvalid>")
    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p></body>")

    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p><plaintext>")
    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p><object><param></param></object>")
    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p><iframe src='http://evil.example.org'></iframe>")
    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p><iframe src='http://evil.example.org'>")

    assert_equal "<p>para</p>", HtmlCleaner.clean("<p>para</p><invalid>invalid</invalid>")

    assert_equal "<a href=\"http://example.org\">para</a>", HtmlCleaner.clean("<a href='http://example.org'>para</a>")
    assert_equal "<a href=\"http://example.org/proc?a&amp;b\">para</a>", HtmlCleaner.clean("<a href='http://example.org/proc?a&b'>para</a>")

    assert_equal "<p>two</p>", HtmlCleaner.clean("<p>para</p><body><p>two</p></body>")
    assert_equal "<p>two</p>", HtmlCleaner.clean("<p>para</p><body><p>two</p>")
    assert_equal "<p>para</p>&lt;bo /dy&gt;<p>two</p>", HtmlCleaner.clean("<p>para</p><bo /dy><p>two</p></body>")
    assert_equal "<p>para</p>&lt;bo\\/dy&gt;<p>two</p>", HtmlCleaner.clean("<p>para</p><bo\\/dy><p>two</p></body>")
    assert_equal "<p>two</p>", HtmlCleaner.clean("<p>para</p><body/><p>two</p></body>")

    assert_equal "<p>one &amp; two</p>", HtmlCleaner.clean(HtmlCleaner.clean("<p>one & two</p>"))

    assert_equal "<p id=\"p\">para</p>", HtmlCleaner.clean("<p id=\"p\" ignore=\"this\">para</p>")
    assert_equal "<p id=\"p\">para</p>", HtmlCleaner.clean("<p id=\"p\" onclick=\"this\">para</p>")

    assert_equal "<img src=\"http://example.org/pic\" />", HtmlCleaner.clean("<img src=\"http://example.org/pic\" />")
    assert_equal "<img />", HtmlCleaner.clean("<img src=\"jav a script:call()\" />")

    assert_equal "what's new", HtmlCleaner.clean("what&#000039;s new")
    assert_equal "&quot;what's new?&quot;", HtmlCleaner.clean("\"what&apos;s new?\"")
    assert_equal "&quot;what's new?&quot;", HtmlCleaner.clean("&quot;what&apos;s new?&quot;")

    # Real-world examples from selected feeds
    assert_equal "I have a heavily subnet&#8217;d/vlan&#8217;d network,", HtmlCleaner.clean("I have a heavily subnet&#8217;d/vlan&#8217;d network,")

    assert_equal "<pre><blockquote>&lt;%= start_form_tag :action =&gt; &quot;create&quot; %&gt;</blockquote></pre>",
                 HtmlCleaner.clean("<pre><blockquote>&lt;%= start_form_tag :action => \"create\" %></blockquote></pre>")

    assert_equal "<a href=\"http://www.mcall.com/news/local/all-smashedmachine1107-cn,0,1574203.story?coll=all-news-hed\">[link]</a><a href=\"http://reddit.com/info/pyhc/comments\">[more]</a>",
                 HtmlCleaner.clean("&lt;a href=\"http://www.mcall.com/news/local/all-smashedmachine1107-cn,0,1574203.story?coll=all-news-hed\"&gt;[link]&lt;/a&gt;&lt;a href=\"http://reddit.com/info/pyhc/comments\"&gt;[more]&lt;/a&gt;")


    # Various exploits from the past
    assert_equal "", HtmlCleaner.clean("<_img foo=\"<IFRAME width='80%' height='400' src='http://alive.znep.com/~marcs/passport/grabit.html'></IFRAME>\" >")
    assert_equal "<a href=\"https://bugzilla.mozilla.org/attachment.cgi?id=&amp;action=force_internal_error&lt;script&gt;alert(document.cookie)&lt;/script&gt;\">link</a>",
                 HtmlCleaner.clean("<a href=\"https://bugzilla.mozilla.org/attachment.cgi?id=&action=force_internal_error<script>alert(document.cookie)</script>\">link</a>")
    assert_equal "<img src=\"doesntexist.jpg\" />", HtmlCleaner.clean("<img src='doesntexist.jpg' onerror='alert(document.cookie)'/>")
    assert_equal "<img src=\"'doesntexist.jpg\" />", HtmlCleaner.clean("<img src=\"'doesntexist.jpg\" onmouseover=\"alert('img-ob-11');''\"/>")
    assert_equal "&lt;IMG &quot;&quot;&quot;&gt;&quot;&gt;", HtmlCleaner.clean("<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">")

    # This doesnt come out as I would like, but the result is still safe.
    # (Apparently, this would work in Gecko.)
    assert HtmlCleaner.clean("<p onclick!\#$%&()*~+-_.,:;?@[/|\\]^=alert(\"XSS\")>para</p>") !~ /\<\>/
    assert_equal "&lt;SCRIPT/XSS SRC=&quot;http://ha.ckers.org/xss.js&quot;&gt;", HtmlCleaner.clean("<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>")

    assert_equal "", HtmlCleaner.clean("<!--[if gte IE 4]><SCRIPT>alert('XSS');</SCRIPT><![endif]-->")
    assert_equal "<p></p>", HtmlCleaner.clean("<p><!--[if gte IE 4]><SCRIPT>alert('XSS');</SCRIPT><![endif]--></p>")
    assert_equal "<p>hi</p><p></p>", HtmlCleaner.clean("<p>hi</p><p><!--[if gte IE 4]><SCRIPT>alert('XSS');</SCRIPT><![endif]--></p>")

    assert_equal "<p>hello</p>", HtmlCleaner.clean("<p>h<!-- hoho -->ell<!-- hoho -->o</p>")
  end

  def test_html_flatten
    assert_equal "", HtmlCleaner.flatten("")

    assert_equal "hello", HtmlCleaner.flatten("hello")
    assert_equal "hello world", HtmlCleaner.flatten("hello\nworld")

    assert_equal "A &gt; B : C", HtmlCleaner.flatten("A > B : C")
    assert_equal "what's new", HtmlCleaner.flatten("what&#39;s new")
    assert_equal "&quot;what's new?&quot;", HtmlCleaner.flatten("\"what&apos;s new?\"")

    assert_equal "we&#8217;ve got &lt;a hre", HtmlCleaner.flatten("we&#8217;ve got <a hre")

    assert_equal "http://example.org", HtmlCleaner.flatten("http://example.org")
    assert_equal "http://example.org/proc?a&amp;b", HtmlCleaner.flatten("http://example.org/proc?a&b")

    assert_equal "&quot;what's new?&quot;", HtmlCleaner.flatten(HtmlCleaner.flatten("\"what&apos;s new?\""))
  end

  def test_dodgy_uri
    # All of these javascript urls work in IE6.
    assert HtmlCleaner.dodgy_uri?("javascript:alert('HI');")
    assert HtmlCleaner.dodgy_uri?(" &#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116; \n :alert('HI');")
    assert HtmlCleaner.dodgy_uri?("JaVaScRiPt:alert('HI');")
    assert HtmlCleaner.dodgy_uri?("JaV   \naSc\nRiPt:alert('HI');")

    # entities lacking ending ';'
    # This only works if they're all packed together without spacing.
    assert HtmlCleaner.dodgy_uri?("&#106&#97&#118&#97&#115&#99&#114&#105&#112&#116&#58&#97&#108&#101&#114&#116&#40&#39&#105&#109&#103&#45&#111&#98&#45&#50&#39&#41")
    assert HtmlCleaner.dodgy_uri?("&#106&#97&#118&#97&#115&#99&#114&#105&#112&#116&#58&#97&#108&#101&#114&#116&#40&#39&#105&#109&#103&#45&#111&#98&#45&#50&#39 &#41 ; ")
    # catch extra spacing anyway.. support for this is possible, depending where the spaces are.
    assert HtmlCleaner.dodgy_uri?("&#106 &#97 &#118 &#97 &#115 &#99 &#114 &#105 &#112 &#116 &#58 &#97 &#108 &#101 &#114 &#116 &#40 &#39 &#105 &#109 &#103 &#45 &#111 &#98 &#45 &#50 &#39 &#41 ; ")
    assert HtmlCleaner.dodgy_uri?("&#x06a &#97 &#118 &#97 &#115 &#99 &#114 &#105 &#112 &#116 &#58 &#97 &#108 &#101 &#114 &#116 &#40 &#39 &#105 &#109 &#103 &#45 &#111 &#98 &#45 &#50 &#39 &#41 ; ")
    assert HtmlCleaner.dodgy_uri?("&#106avascript")
    assert HtmlCleaner.dodgy_uri?("&#x06a;avascript")

    # url-encoded
    assert HtmlCleaner.dodgy_uri?("%6A%61%76%61%73%63%72%69%70%74%3A%61%6C%65%72%74%28%27%69%6D%67%2D%6F%62%2D%33%27%29")

    # Other evil schemes
    assert HtmlCleaner.dodgy_uri?("vbscript:MsgBox(\"hi\")")
    assert HtmlCleaner.dodgy_uri?("mocha:alert('hi')")
    assert HtmlCleaner.dodgy_uri?("livescript:alert('hi')")
    assert HtmlCleaner.dodgy_uri?("data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K")

    # Various non-printing chars
    assert HtmlCleaner.dodgy_uri?("javas\0cript:foo()")
    assert HtmlCleaner.dodgy_uri?(" &#14; javascript:foo()")
    assert HtmlCleaner.dodgy_uri?("jav&#x0A;ascript:foo()")
    assert HtmlCleaner.dodgy_uri?("jav&#x09;ascript:foo()")
    assert HtmlCleaner.dodgy_uri?("jav\tascript:foo()")

    # The Good
    assert_nil HtmlCleaner.dodgy_uri?(nil)
    assert_nil HtmlCleaner.dodgy_uri?("http://example.org")
    assert_nil HtmlCleaner.dodgy_uri?("http://example.org/foo.html")
    assert_nil HtmlCleaner.dodgy_uri?("http://example.org/foo.cgi?x=y&a=b")
    assert_nil HtmlCleaner.dodgy_uri?("http://example.org/foo.cgi?x=y&amp;a=b")
    assert_nil HtmlCleaner.dodgy_uri?("http://example.org/foo.cgi?x=y&#38;a=b")
    assert_nil HtmlCleaner.dodgy_uri?("http://example.org/foo.cgi?x=y&#x56;a=b")
  end

end
