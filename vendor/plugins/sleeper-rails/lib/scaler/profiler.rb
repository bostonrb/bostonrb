module Scaler
  module Profiler
	mattr_accessor :enabled

	def self.enable!; @@enabled=true; end
	def self.disable!; @@enabled=false; end
		    
    def start_profiling
		if @@enabled then
      		RubyProf.start rescue RuntimeError
		end
    end
    
    def finish_profiling
		if @@enabled then
      		results = RubyProf.stop
      		output = String.new
      		RubyProf::FlatPrinter.new(results).print(output,0)
      
      		Scaler.statistics.add_to_this_request({'profiling'=>output})
		end
    end
   
    def self.included(base)
      base.send 'before_filter', 'start_profiling'
	  base.send 'after_filter', 'finish_profiling'
    end 
  end
end