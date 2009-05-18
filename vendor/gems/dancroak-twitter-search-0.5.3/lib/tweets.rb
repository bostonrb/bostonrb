module TwitterSearch
  class Tweet
    VARS = [:text, :from_user, :to_user, :to_user_id, :id, :iso_language_code, :from_user_id, :created_at, :profile_image_url, :source ]
    attr_reader *VARS
    attr_reader :language
    
    def initialize(opts)
      @language = opts['iso_language_code']
      VARS.each { |each| instance_variable_set "@#{each}", opts[each.to_s] }
    end
  end

  class Tweets
    VARS = [:since_id, :max_id, :results_per_page, :page, :query, :next_page]
    attr_reader *VARS

    include Enumerable

    def initialize(opts)
      @results = opts['results'].collect { |each| Tweet.new(each) }
      VARS.each { |each| instance_variable_set "@#{each}", opts[each.to_s] }
    end

    def each(&block)
      @results.each(&block)
    end

    def size
      @results.size
    end
    
    def [](index)
      @results[index]
    end

    def has_next_page?
      ! @next_page.nil?
    end

    def get_next_page
      client = Client.new
      return client.query( CGI.parse( @next_page[1..-1] ) )
    end
  end
end