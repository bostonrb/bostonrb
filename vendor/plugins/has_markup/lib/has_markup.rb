module HasMarkup  
  # Modules to extend ActiveRecord
  module ActiveRecord # :nodoc:
    # Methods that are added to ActiveRecord::Base
    module ClassMethods
      # Adds the following methods for dealing with markup, using <tt>has_markup :content</tt> as an example:
      # * <tt>content_html</tt> for generating the html of <tt>:content</tt>.
      # 
      # Options are:
      # * <tt>:required</tt> - column is required
      # * <tt>:syntax</tt> - syntax of the markup. Currently supports only :markdown, which is the default.
      # * <tt>:cache_html</tt> - html generated from the markup should be cached in a column. Following the
      #   example of using <tt>:content</tt>, it would require a column named <tt>:cached_content_html</tt>.
      #   It also adds a before_save hook <tt>:cache_content_html</tt> for generating the html before saving.
      #
      # To support other syntaxes, you just need to add a method on ActiveRecord::Base named like
      # <tt>sprinkle_ursyntax_magic</tt> which takes a column (where <tt>ursyntax</tt> is the name
      # of your awesome syntax). You should define a method named
      # "#{column}_html" which generates the html from the markup. You might also want to validate
      # the syntax of the column.
      def has_markup(column, options = {})
        options = HasMarkup::default_has_markup_options.merge(options)
        
        validates_presence_of column if options[:required]

        if syntax_supported? options[:syntax]
          sprinkle_markup_syntax_magic column, options[:syntax]
        else
          raise "Unsupported syntax #{syntax.inspect}. has_markup currently supports :markdown"
        end

        sprinkle_html_caching_magic column if options[:cache_html]
      end

      def validates_markdown_syntax(*columns)
        validates_each(*columns) do |record, column, value|
          begin
            BlueCloth.new(value).to_html unless value.nil?
          rescue BlueCloth::FormatError => e
            errors.add column, "has #{e}" 
          end
        end
      end
      
      # Sprinkles the appropriate magic to support the given syntax on the given column.
      # Assumes that the syntax is supported.
      def sprinkle_markup_syntax_magic(column, syntax)
        self.send("sprinkle_#{syntax}_magic", column)
      end
      
      # Is the given syntax supported? This really just asks if there's a method named
      # "sprinkle_#{syntax}_magic".
      def syntax_supported?(syntax)
        self.respond_to? "sprinkle_#{syntax}_magic"
      end
      
      # Sprinkles the magic needed to support markdown. In particular, it will validate the markdown syntax
      # on the column, and define a method <tt>column_html</tt> which uses BlueCloth to generate HTML.
      def sprinkle_markdown_magic(column)
        require 'bluecloth'
        
        validates_markdown_syntax column
        define_method "#{column}_html" do
          markup = self.send(column)
          BlueCloth.new(markup).to_html unless markup.blank?
        end
      end
      
      # Sprinkles the magic for caching the html of the given
      def sprinkle_html_caching_magic(column)
        define_method "cache_#{column}_html" do
          html = self.send("#{column}_html")
          self.send("cached_#{column}_html=", html)
        end
        before_save "cache_#{column}_html".to_sym
      end
    end    
  end
  
  def self.default_has_markup_options
    {
      :syntax => :markdown,
      :required => false,
      :cache_html => false
    }
  end
end

require 'active_record'
module ActiveRecord # :nodoc:all
  class Base
    extend HasMarkup::ActiveRecord::ClassMethods
  end
end
