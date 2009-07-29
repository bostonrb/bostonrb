module Feedra
  module FeedError

    def self.included(other)
      other.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def create_from_feedzirra_error(feedzirra_error)
        attributes = {:error_type => feedzirra_error.class.to_s}

        attributes[:message] = if feedzirra_error.respond_to?(:message)
                                 feedzirra_error.message
                               else
                                 feedzirra_error.inspect
                               end
        if feedzirra_error.respond_to?(:backtrace)
          attributes[:backtrace] = feedzirra_error.backtrace
        end

        create(attributes)
      end

    end

  end
end

