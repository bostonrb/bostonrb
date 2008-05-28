
module FeedNormalizer

  module Singular

    # If the method being called is a singular (in this simple case, does not
    # end with an 's'), then it calls the plural method, and calls the first
    # element. We're assuming that plural methods provide an array.
    #
    # Example:
    # Object contains an array called 'alphas', which looks like [:a, :b, :c].
    # Call object.alpha and :a is returned.
    def method_missing(name, *args)
      return self.send(:"#{name}s").first rescue super(name, *args)
    end

    def respond_to?(x, y=false)
      self.class::ELEMENTS.include?(x) || self.class::ELEMENTS.include?(:"#{x}s") || super(x, y)
    end

  end

  module ElementEquality

    def eql?(other)
      self == (other)
    end

    def ==(other)
      other.equal?(self) ||
        (other.instance_of?(self.class) &&
          self.class::ELEMENTS.all?{ |el| self.send(el) == other.send(el)} )
    end

    # Returns the difference between two Feed instances as a hash.
    # Any top-level differences in the Feed object as presented as:
    #
    #  { :title => [content, other_content] }
    #
    # For differences at the items level, an array of hashes shows the diffs
    # on a per-entry basis. Only entries that differ will contain a hash:
    #
    #  { :items => [
    #     {:title => ["An article tile", "A new article title"]},
    #     {:title => ["one title", "a different title"]} ]}
    #
    # If the number of items in each feed are different, then the count of each
    # is provided instead:
    #
    #  { :items => [4,5] }
    #
    # This method can also be useful for human-readable feed comparison if
    # its output is dumped to YAML.
    def diff(other, elements = self.class::ELEMENTS)
      diffs = {}

      elements.each do |element|
        if other.respond_to?(element)
          self_value = self.send(element)
          other_value = other.send(element)

          next if self_value == other_value

          diffs[element] = if other_value.respond_to?(:diff)
            self_value.diff(other_value)

          elsif other_value.is_a?(Enumerable) && other_value.all?{|v| v.respond_to?(:diff)}

            if self_value.size != other_value.size
              [self_value.size, other_value.size]
            else
              enum_diffs = []
              self_value.each_with_index do |val, index|
                enum_diffs << val.diff(other_value[index], val.class::ELEMENTS)
              end
              enum_diffs.reject{|h| h.empty?}
            end

          else
            [other_value, self_value] unless other_value == self_value
          end
        end
      end

      diffs
    end

  end

  module ElementCleaner
    # Recursively cleans all elements in place.
    #
    # Only allow tags in whitelist. Always parse the html with a parser and delete
    # all tags that arent on the list.
    #
    # For feed elements that can contain HTML:
    # - feed.(title|description)
    # - feed.entries[n].(title|description|content)
    #
    def clean!
      self.class::SIMPLE_ELEMENTS.each do |element|
        val = self.send(element)

        send("#{element}=", (val.is_a?(Array) ?
          val.collect{|v| HtmlCleaner.flatten(v.to_s)} : HtmlCleaner.flatten(val.to_s)))
      end

      self.class::HTML_ELEMENTS.each do |element|
        send("#{element}=", HtmlCleaner.clean(self.send(element).to_s))
      end

      self.class::BLENDED_ELEMENTS.each do |element|
        self.send(element).collect{|v| v.clean!}
      end
    end
  end


  # Represents a feed item entry.
  class Entry
    include Singular, ElementEquality, ElementCleaner

    HTML_ELEMENTS = [:content, :description, :title]
    SIMPLE_ELEMENTS = [:date_published, :urls, :id, :authors, :copyright, :categories]
    BLENDED_ELEMENTS = []

    ELEMENTS = HTML_ELEMENTS + SIMPLE_ELEMENTS + BLENDED_ELEMENTS

    attr_accessor(*ELEMENTS)

    def initialize
      @urls = []
      @authors = []
      @categories = []
    end

  end

  # Represents the root element of a feed.
  class Feed
    include Singular, ElementEquality, ElementCleaner

    # Elements that can contain HTML fragments.
    HTML_ELEMENTS = [:title, :description]

    # Elements that contain 'plain' Strings, with HTML escaped.
    SIMPLE_ELEMENTS = [:id, :last_updated, :copyright, :authors, :urls, :image, :generator]

    # Elements that contain both HTML and escaped HTML.
    BLENDED_ELEMENTS = [:items]

    ELEMENTS = HTML_ELEMENTS + SIMPLE_ELEMENTS + BLENDED_ELEMENTS

    attr_accessor(*ELEMENTS)
    attr_accessor(:parser)

    alias :entries :items

    def initialize(wrapper)
      # set up associations (i.e. arrays where needed)
      @urls = []
      @authors = []
      @items = []
      @parser = wrapper.parser.to_s
    end

    def channel() self end

  end

end

