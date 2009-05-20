module HasMarkup
  # Provides HasMarkup with markdown[http://daringfireball.net/projects/markdown/] support.
  module Markdown
    # Sprinkles the magic needed to support markdown. In particular, it will validate the markdown syntax
    # on the column, and define a method <tt>column_html</tt> which uses BlueCloth to generate HTML.
    def sprinkle_markdown_magic(column)
      require 'bluecloth'
    
      extend HasMarkup::Markdown::ClassMethods
      include HasMarkup::Markdown::InstanceMethods
    
      validates_markdown_syntax column
      define_method "#{column}_html" do
        markdown = self.send(column)
        self.generate_html_from_markdown(markdown)
      end
    end
    
    module InstanceMethods
      def generate_html_from_markdown(markdown)
        BlueCloth.new(markdown).to_html unless markdown.blank?
      end
    end
    
    module ClassMethods
      # Validates the markdown syntax of the given columns.
      def validates_markdown_syntax(*columns)
        validates_each(*columns) do |record, column, value|
          begin
            record.generate_html_from_markdown(value)
          rescue BlueCloth::FormatError => e
            record.errors.add column, "has #{e}"
          end
        end
      end
    end
  end
end