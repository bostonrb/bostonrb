module UtilityScopes
  module Eager
    
    def self.included(within)
      within.class_eval do
        named_scope :with, lambda { |*associations| { :include => associations } }
      end
    end
  end
end