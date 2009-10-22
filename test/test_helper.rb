ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  # Uncomment to not quiet backtrace
  #Rails.backtrace_cleaner.remove_silencers! 

  def file_fixture(name)
    File.read(File.join(File.dirname(__FILE__), "file_fixtures", name))
  end

  def stubbed_action_view
    view = ActionView::Base.new(@controller.class.view_paths, {}, @controller)
    yield view
    ActionView::Base.stubs(:new).returns(view)
  end

  def paginate(*array)
    array.paginate
  end
end

module StubChainMocha
  module Object
    def stub_chain(*methods)
      while methods.length > 1 do
        stubs(methods.shift).returns(self)
      end
      stubs(methods.shift)
    end
  end
end

Object.send(:include, StubChainMocha::Object)

