require 'shoulda'

module HasMarkup # :nodoc:
  # Shoulda macros for has_markup. These get added to <tt>Test::Unit::TestCase</tt>.
  module Shoulda
    # Ensure that markup is cached.
    #
    #   should_cache_markup :content
    def should_cache_markup(column)
      should_have_db_column "cached_#{column}_html"
      should_have_instance_methods "set_cached_#{column}_html"
      # TODO test that there's before_save action happening
    end
    
    # Ensure that markup is required.
    #
    #   should_require_markup :content
    def should_require_markup(column)
      should_require_attributes column
    end
    
    # Ensure that the model has markup. Accepts all the same options that has_markup does.
    #
    #   should_have_markup :content
    def should_have_markup(column, options = {})
      options = HasMarkup::default_has_markup_options.merge(options)
      should_have_instance_methods "#{column}_html"

      should_require_markup column if options[:required]

      should_cache_markup column if options[:cache_html]
    end    
  end
end

module Test # :nodoc: all
  module Unit 
    class TestCase
      extend HasMarkup::Shoulda
    end
  end
end
