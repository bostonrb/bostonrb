#TODO: use base_class to get rid off duplication?
module UtilityScopes
  module Ordered
    
    def self.included(base)
      base.extend ClassMethods
      
      base.class_eval do
        # Provide an ordered scope
        named_scope(:ordered, lambda { |*order|
          { :order => case
            when order.empty?
              self.default_ordering
            # allow hash support for jruby or ruby 1.9
            when order.size == 1 && order[0].is_a?(Hash) && (PLATFORM=~/java/ || RUBY_VERSION=~/1\.9.*/)
              order.first.collect{|(k,v)| "#{k} #{v.to_s.upcase}"}.join(', ')
            else
              order.collect{|e| e.is_a?(Array) ? "#{e[0]} #{e[1].to_s.upcase}" : e}.join(', ')
            end
          }
        })
        
        class << self
          # Set alias order_by
          alias_method :order_by, :ordered
          # Set alias sort_by
          alias_method :sort_by, :ordered
          # Set the default order
          define_method(:default_ordering) { 'created_at DESC' }
        end
      end
    end
    
    module ClassMethods
      
      # Decorate this class with the ability to order itself in queries
      # either from a given parameter or from its default ordering:
      #
      #   class Article < ActiveRecord::Base
      #     ordered_by "published_at DESC"
      #   end
      #
      #   Article.ordered #=> all items ordered by "published_at DESC"
      #   Article.ordered('popularity ASC') #=> all items ordered by "popularity ASC"
      #   Article.default_ordering #=> "published_at DESC"
      #
      def ordered_by(clause)
        # Override named scope on AR::Base so we can access default_ordering
        # on subclass
        named_scope(:ordered, lambda { |*order|
          { :order => case
            when order.empty?
              self.default_ordering
            # allow hash support for jruby or ruby 1.9
            when order.size == 1 && order[0].is_a?(Hash) && (PLATFORM=~/java/ || RUBY_VERSION=~/1\.9.*/)
              order.first.collect{|(k,v)| "#{k} #{v.to_s.upcase}"}.join(', ')
            else
              order.collect{|e| e.is_a?(Array) ? "#{e[0]} #{e[1].to_s.upcase}" : e}.join(', ') 
            end
          }
        })
        
        metaclass.instance_eval do
          define_method(:default_ordering) { clause }
        end
      end
      
      def method_missing(method, *args, &block)
        col = method.to_s.match(/^(order_by_|sort_by_)(.*)$/)[2] rescue false
        if col && self.columns.collect{ |c| c.name }.include?(col)
          return self.order_by(col, *args, &block)
        else
          super
        end
      end
      
      private
      
      def metaclass; class << self; self end; end
    end
  end
end
