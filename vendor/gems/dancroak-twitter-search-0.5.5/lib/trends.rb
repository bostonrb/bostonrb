module TwitterSearch
  class Trend
    VARS = [ :query, :name ]
    attr_reader *VARS
    attr_reader :exclude_hashtags

    def initialize(opts)
      @exclude_hashtags = !!opts['exclude_hashtags']
      VARS.each { |each| instance_variable_set "@#{each}", opts[each.to_s] }
    end
  end

  class Trends
    VARS = [:date]
    attr_reader *VARS

    include Enumerable

    def initialize(opts)
      @trends = opts['trends'].values.first.collect { |each| Trend.new(each) }
      VARS.each { |each| instance_variable_set "@#{each}", opts[each.to_s] }
    end

    def each(&block)
      @trends.each(&block)
    end

    def size
      @trends.size
    end

    def [](index)
      @trends[index]
    end
  end
end
