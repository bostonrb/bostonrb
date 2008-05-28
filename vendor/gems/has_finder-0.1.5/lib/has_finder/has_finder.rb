module HasFinder
  class FinderProxy
    attr_reader :proxy_finder, :proxy_scope
    [].methods.each { |m| delegate m, :to => :proxy_found unless m =~ /(^__|^nil\?|^send|class|extend|find|count|sum|average|maximum|minimum|paginate)/ }
    delegate :finders, :with_scope, :to => :proxy_finder
    
    def initialize(proxy_finder, options, &block)
      extend options.delete(:extend) if options[:extend]
      extend Module.new(&block) if block_given?
      @proxy_finder, @proxy_scope = proxy_finder, options
    end
    
    def reload
      load_found; self
    end
        
    protected
    def proxy_found
      @found ||= load_found
    end
    
    private
    def method_missing(method, *args, &block)
      if finders.include?(method)
        finders[method].call(self, *args)
      else
        with_scope :find => proxy_scope do
          proxy_finder.send(method, *args, &block)
        end
      end
    end
    
    def load_found
      find(:all)
    end
  end

  module ActiveRecord
    def self.included(ar)
      ar.extend ClassMethods
    end

    module ClassMethods
      def finders
        write_inheritable_attribute(:finders, {}) if read_inheritable_attribute(:finders).nil?
        read_inheritable_attribute(:finders)
      end
      
      def has_finder(name, options = {}, &block)
        finders[name] = lambda do |parent_finder, *args|
          FinderProxy.new(parent_finder, case options
            when Hash
              options
            when Proc
              options.call(*args)
          end, &block)
        end
        meta_def(name) do |*args|
          finders[name].call(self, *args)
        end
      end
    end
  end

  module HasManyAssociation
    def self.included(ap)
      ap.class_eval do
        alias_method_chain :method_missing, :has_finder
      end
    end

    def method_missing_with_has_finder(method, *args, &block)
      if @reflection.klass.finders.include?(method)
        @reflection.klass.finders[method].call(self, *args)
      else
        method_missing_without_has_finder(method, *args, &block)
      end
    end
  end
end

ActiveRecord::Base.send(:include, HasFinder::ActiveRecord)
[ActiveRecord::Associations::HasManyAssociation, ActiveRecord::Associations::HasManyThroughAssociation].each do |c|
  c.send(:include, HasFinder::HasManyAssociation)
end