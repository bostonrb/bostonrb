module Scaler
  class HostStats
  
    def self.free_memory
      # TODO: jruby love
      if RUBY_PLATFORM =~ /linux/ then
        meminfo = %x[cat /proc/meminfo].split("\n")
		    free = ''
		    cached = ''
        meminfo.each{|line|
          free = $1 if line.match(/^MemFree:[ \t]+(.*)$/)
          cached = $1 if line.match(/^Cached:[ \t]+(.*)$/)
          }
        [free,cached]
      elsif RUBY_PLATFORM =~ /darwin/ then
        meminfo = %x[vm_stat].split("\n")
        pagesize=0;free=0;cached=0;
         meminfo.each{|line|
           if line.match(/(page size of (.*) bytes)/)
            pagesize = $1
          end
            free = $1 if line.match(/^Pages free:[ \t]+(.*)/)
            cached = $1 if line.match(/^Cached:[ \t]+(.*)/)
            }
        [pagesize,free,cached]
      elsif RUBY_PLATFORM =~ /mswin32/ then
        raise(UsingWindowsError,'i dont have a windows box.')
      end
    end
    
    def self.disk_space
      
    end
    
    def self.load_average
      if RUBY_PLATFORM =~ /linux/ then
        %x[cat /proc/loadavg]
      elsif RUBY_PLATFORM =~ /darwin/ then
        %x[sysctl vm.loadavg].match(/\{ (.*) \}/)[1]
      elsif RUBY_PLATFORM =~ /mswin32/ then
        raise(UsingWindowsError,'i dont have a windows box to code this up with :(')
      end
    end
  
  end
end