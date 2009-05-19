module UtilityScopes
  module Except
    
    def self.included(within)      
      within.class_eval do
        
        # Give every class the ability to add to itself the except named
        # scope
        extend ClassMethods
        
        # And automatically do so for all its subclasses
        def self.inherited_with_except_scope_hook(child)
          inherited_without_except_scope_hook(child)
          child.attach_except_utility_scope
        end
        class << self
          alias_method_chain :inherited, :except_scope_hook
        end
      end
    end
    
    module ClassMethods
      
      # Must be a class method called directly on AR::Base subclasses
      # so named_scope knows who its base class, and thus, table_name
      # and primary_key are.
      def attach_except_utility_scope
      
        # Allow easy rejection of items. 
        # Can take an a single id or ActiveRecord object, or an array of them
        # Example: 
        #   before   Article.all.reject{|a| a == @bad_article }
        #   after    Article.except(@bad_article)
        named_scope :except, lambda { |item_or_list|
          # nil or empty array causes issues here with mysql
          item_or_list.blank? ? {} : {:conditions => ["#{quoted_table_name}.#{primary_key} NOT IN (?)", item_or_list]}
        }
      end      
    end
  end
end