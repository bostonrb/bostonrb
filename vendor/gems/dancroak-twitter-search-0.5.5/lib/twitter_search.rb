require 'rubygems'
require 'net/http'
require 'json'
require 'cgi'

require File.join(File.dirname(__FILE__), 'tweets')
require File.join(File.dirname(__FILE__), 'trends')

module TwitterSearch
  class SearchOperatorError < ArgumentError
  end

  class Client
    TWITTER_SEARCH_API_URL = 'http://search.twitter.com/search.json'
    TWITTER_TRENDS_API_URL = 'http://search.twitter.com/trends/current.json'
    DEFAULT_TIMEOUT = 5

    attr_accessor :agent
    attr_accessor :timeout

    def initialize(agent = 'twitter-search', timeout = DEFAULT_TIMEOUT)
      @agent = agent
      @timeout = timeout
    end

    def headers
      { "Content-Type" => 'application/json',
        "User-Agent"   => @agent }
    end

    def query(opts = {})
      url       = URI.parse(TWITTER_SEARCH_API_URL)
      url.query = sanitize_query(opts)

      ensure_no_location_operators(url.query)

      req  = Net::HTTP::Get.new(url.path)
      http = Net::HTTP.new(url.host, url.port)
      http.read_timeout = timeout

      json = http.start { |http|
        http.get("#{url.path}?#{url.query}", headers)
      }.body
      Tweets.new JSON.parse(json)
    end

    def trends(opts = {})
      url = URI.parse(TWITTER_TRENDS_API_URL)
      if opts['exclude_hashtags']
        url.query = sanitize_query_hash({ :exclude_hashtags => opts['exclude_hashtags'] })
      end

      req  = Net::HTTP::Get.new(url.path)
      http = Net::HTTP.new(url.host, url.port)
      http.read_timeout = timeout

      json = http.start { |http|
        http.get("#{url.path}?#{url.query}", headers)
      }.body
      Trends.new JSON.parse(json)
    end

    private

      def sanitize_query(opts)
        if opts.is_a? String
          "q=#{CGI.escape(opts)}"
        elsif opts.is_a? Hash
          "#{sanitize_query_hash(opts)}"
        end
      end

      def sanitize_query_hash(query_hash)
        query_hash.collect { |key, value|
          "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
        }.join('&')
      end

      def ensure_no_location_operators(query_string)
        if query_string.include?("near%3A") ||
           query_string.include?("within%3A")
          raise TwitterSearch::SearchOperatorError,
            "near: and within: are available from the Twitter Search web interface, but not the API. The API requires the geocode parameter. See dancroak/twitter-search README."
        end
      end

  end
end
