module FastRandom
  module ClassMethods
    def random
      if (c = count) != 0
        find(:first, :offset => rand(c))
      end
    end
  end

  ActiveRecord::Base.class_eval do
    extend ClassMethods
  end
end


