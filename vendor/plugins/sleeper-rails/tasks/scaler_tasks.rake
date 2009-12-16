# desc "Explaining what the task does"
# task :scaler do
#   # Task goes here
# end

def parents(obj)
  ( (obj.superclass ? parents(obj.superclass) : []) << obj). reverse
end


namespace(:sleeper) do
	
	desc('Walk around a site, push buttons, pull levers, and generally try to wreak havoc.')
	task :walk => :environment do |t,args|
		@w = Scaler::Walker.new(args.host,true)
		@w.walk!(args.depth || 10)
	end
	
	desc('Notify sleeper that we\'ve just deployed.')
	task :deploy do
		
	end
	
	desc('Sanity check your app to make sure it\'s a sane environment, DB, and plugins.')
	task :test => :environment do
		# begin sanity checks
		printf "First we're going to check your app to make sure it's sane and happy and meets the requirements for Sleeper.\n"
		printf "Database backend:\t"
		if (File.exists?(RAILS_ROOT+'/config/database.yml')) then
			# check for MySQL usage at least somewhere :)
			
			printf "[OK!]\n"
		else
			printf "[FAIL!]\nLooks like you don't have any database configured! This might be totally fine, but Sleeper currently only collects explanation data with a MySQL backend, so keep this in mind if you're planning on using PostgreSQL or another DB backend.\n"
		end


		printf "ORM:\t\t\t"
		# hat tip: http://blog.matt-darby.com/posts/692-iterating-over-all-models-in-rails
		# TODO: nested models
		# TODO: blacklist instead of whitelist
		all_models = Dir.glob( File.join( RAILS_ROOT, 'app', 'models', '*.rb') ).map{|path| path[/.+\/(.+).rb/,1] }
		failures = []
		we_ok = all_models.collect{|m| 
			begin
				pts = parents(m.classify.constantize).collect{|parent| parent.to_s }
				val = (pts.include?('ActiveRecord::Base') or pts.include?('Authlogic::Session::Base') or pts.include?('ActionMailer::Base'))
				failures << m.classify.constantize unless val
				val
			rescue Exception => e
				failures << m.to_s
			end
		 }.inject{|memo,obj| memo && obj }
		
		if we_ok then
				printf "[OK!]\n"
			else
				printf "[FAIL!]\n - Looks like you've got some non-activerecord models (#{failures.join(',')}). This may be fine, or this may be indicative of future problems you'll run into!\n"
			end

		# check for Rails and not merb
		print "Application Framework:\t"
		if defined?(Rails) then
			printf "[OK!]\n"
		else
			printf "[FAIL!]\nLooks like you're not using Rails - this may be a nono!\n"
		end
			
		printf "Plugin Conflicts:\t[OK!]\n" # TODO as we discover plugin issues :)
	end
	
	desc('Install and configure a basic Sleeper installation.')
	task :install do
		
		@config = {}
		
		printf <<-EOM
====================================
  _____ _                           
 / ____| |                          
| (___ | | ___  ___ _ __   ___ _ __ 
 \\___ \\| |/ _ \\/ _ \\ '_ \\ / _ \\ '__|
 ____) | |  __/  __/ |_) |  __/ |   
|_____/|_|\\___|\\___| .__/ \\___|_|   
                   | |              
                   |_|
====================================
Welcome to sleeper! Let's get you up and running as quickly as possible!\n
EOM

	 Rake::Task["sleeper:test"].reenable
   Rake::Task["sleeper:test"].invoke

	if (File.exists?(RAILS_ROOT+'/config/sleeper.yml')) then
		printf "Sleeper is already configured.\n"
	else

		@config[:client_key] = get_key
	
		printf "Now let's ask a couple of quick questions on how you want sleeper to work when it cannot configure itself from the site.\n"
	
		printf "How many seconds do you want between uploading data to the central sleeper server? [60]"
		val = STDIN.gets.chomp.to_i
		@config[:update_time] = val > 0 ? val : 60

		printf "How many seconds do you want between updates of the sleeper configuration? [600]"
		val = STDIN.gets.chomp.to_i
		@config[:config_update_time] = val > 0 ? val : 600

		printf "Do you want to enable debug mode? [n]"
		val = STDIN.gets.chomp.match(/y(es)?/i)
		@config[:debug] = val ? true : false
	
		@file = File.new(RAILS_ROOT+'/config/sleeper.yml','w+')
		@file.write(@config.to_yaml)
		@file.close
	
		printf "\nExcellent, Sleeper is configured and ready to go!\n"	
	end
	end
	
	
	def get_key
		printf "What's your sleeper key? "
		key = STDIN.gets.chomp
		printf "\nYou entered '#{key}', is this correct? (y/n)"
		 return key if (STDIN.gets.match(/^y$/i))
		get_key	
	end
end