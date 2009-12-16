module Scaler
  class Configurator
    
    def default_configuration
      {
        :client_key => nil,
        :client_secret => nil,
        :sleeper_host => 'http://sleeperapp.com',
        :update_time => 60, # in seconds
        :config_update_time => 600, # every ten minutes
        :debug => false,
        :benchmarking => true,
        :explaining => true,
        :traces => false,
				:trace_depth => 10,
        :profiling => false,
        :peeking => false,
				:upload_timeout => 30,
				:compression => true,
				:verbose_statistics => false
      }
    end
    
    def initialize(manual_config=nil)
      @running = true
      
	 		if manual_config
		  	@config = default_configuration.merge(manual_config)
      else
				@config = default_configuration
				output = ERB.new(File.open("#{RAILS_ROOT}/config/sleeper.yml").read).result
				@config.merge!(YAML::load(output)) rescue nil

     		ENV['SLEEPER-CONFIG-THREAD'] = Thread.new { 
            	sleep 5 # initial time before we rock and roll
            	config_thread
          	}.inspect
				
				end
    end
    
    def update_config
      uri = URI.parse(@config[:sleeper_host]+'/apps/'+@config[:client_key]+'/environments/'+Rails.env+'.js')
      result = Net::HTTP.get(uri) rescue nil
      new_config = Hash[*ActiveSupport::JSON.decode(result).collect{|k,v| {k.to_sym=>v} }.collect{|z| z.to_a }.flatten]
      @config.merge!(new_config) rescue nil
      # TODO: re analyze config, uninstall everything and reinstall what needs to be reinstalled

	  # there's a few second hole here where modules will flicker off & on
	  Scaler.unload_modules
	  Scaler.load_modules
    end
    
    def config_thread
      while @running
        begin
          Scaler.log(:config) { 'Updating configuration...' }
          update_config
		rescue ActiveSupport::JSON::ParseError
			Scaler.log(:config) { 'Unable to update configuration, we received some bad JSON. (Is Sleeper down?) We\'ll try again in a few minutes.' }
			sleep 600 # wait 10 minutes, we'll use default behavior for now
        rescue Exception => e
          Scaler.log(:error, Logger::ERROR) { e }
          Scaler.log(:error, Logger::ERROR) { e.backtrace }
        end
        sleep Scaler.config?(:config_update_time)
      end
    end
    
    def config(key);@config[key];end
    
  end
end