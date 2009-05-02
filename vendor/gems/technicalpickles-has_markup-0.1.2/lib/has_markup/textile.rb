module HasMarkup
  # Provides HasMarkup with textile[http://hobix.com/textile/] support
  module Textile
    # Sprinkles the magic needed to support textile. In particular, it will define a method <tt>column_html</tt> which uses RedCloth to
    # generate HTML.
    def sprinkle_textile_magic(column)
      require 'redcloth'
    
      extend HasMarkup::Textile::ClassMethods
      include HasMarkup::Textile::InstanceMethods
    
      validates_textile_syntax column
      define_method "#{column}_html" do
        markdown = self.send(column)
        self.generate_html_from_markdown(markdown)
      end
    end
    
    module InstanceMethods
      def generate_html_from_markdown(textile)
        RedCloth.new(textile).to_html unless textile.blank?
      end
    end
    
    module ClassMethods
      # Validates the markdown syntax of the given columns.
      def validates_textile_syntax(*columns)
        validates_each(*columns) do |record, column, value|
          begin
            record.generate_html_from_markdown(value)
          rescue e
            record.errors.add column, "has #{e}"
          end
        end
      end
    end
  end
end