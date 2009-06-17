# encoding: utf-8
class Test::Unit::TestCase
  def self.should_validate_url_format_of(attribute, options = {})
    should_allow_values_for attribute, 
      'http://example.com',
      'http://example.com/',
      'http://www.example.com/',
      'http://sub.domain.example.com/',
      'http://bbc.co.uk',
      'http://example.com?foo',
      'http://example.com?url=http://example.com',
      'http://example.com:8000',
      'http://www.sub.example.com/page.html?foo=bar&baz=%23#anchor',
      'http://user:pass@example.com',
      'http://user:@example.com',
      'http://example.com/~user',
      'http://example.xy', # Not a real TLD, but we're fine with anything of 2-6 chars
      'http://example.museum',
      'http://1.0.255.249',
      'http://1.2.3.4:80',
      'HttP://example.com',
      'https://example.com',
      'http://räksmörgås.nu', # IDN
      'http://xn--rksmrgs-5wao1o.nu', # Punycode
      'http://example.com.', # Explicit TLD root period
      'http://example.com./foo'

    should_not_allow_values_for attribute,
      "www.example.com",
      "http://ex ample.com",
      "http://example.com/foo bar",
      'http://256.0.0.1',
      'http://u:u:u@example.com',
      'http://r?ksmorgas.com'
  end
end
