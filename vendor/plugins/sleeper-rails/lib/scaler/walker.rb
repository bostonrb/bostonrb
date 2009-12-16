require 'rubygems'
require 'mechanize'
require 'term/ansicolor'

=begin

=end

module Scaler
	class Walker
		include Term::ANSIColor
		
		class OutOfLinks < Exception; end
		
		FORM_THRESHOLD=1
		
		def initialize(base_url,wander_offsite=false)
			print "Walker initializing at #{base_url}...\n"
			@agent = WWW::Mechanize.new
			
			begin
				@page = @agent.get(base_url)
			rescue
				print "#{red}Unable to connect to starting URL (#{base_url}), dying horribly!#{reset}\n"
			end
			
			@wander_offsite = wander_offsite
			@base_host = URI.parse(base_url).host
		end
		
		def sleep_time;rand(3);end
		
		def walk!(how_many=5)
			return unless @page
			how_many.times do
				begin
					explore!
					sleep sleep_time
				rescue OutOfLinks
					
					print "\tNo clickable links here, going back.\n"
				rescue Errno::ECONNREFUSED
					print "#{red}Unable to connect, I'll backpedal.#{reset}]\n"
				rescue Net::HTTPNotFound
					print "#{red}404 not found!#{blue} (#{@page.uri})#{reset}\n"
				end
			end
		end
		
		def fuzz(chars=15, s='')
			chars.enum_for(:times).inject(s) do |result, index|
			    s << rand(74) + 48
			end
		end
		
		def explore!
			print "#{green+bold}#{@page.title}#{reset} [#{blue}(#{@page.uri})#{reset}] - #{@page.links.size} links - #{@page.forms.size} forms\n"
			
			if (rand*@page.forms.size)>FORM_THRESHOLD then
				print "\tI'm going to fill out a form!\n"
				form = @page.forms[rand(@page.forms.size-1)]
				
				form.fields.each {|f|
					if f.value and f.value!="" then
						printf "\t - form field #{f.name} already has a value, so i'm not gonna overwrite it\n" #TODO: fuzz this shit for securrity ;)
					else
						f.value=fuzz
						printf "\t - form field: #{f.name} = #{f.value}\n"
					end
					}
				
				@page = @agent.submit(form)
			else
				links = @page.links.collect{|link|
					@wander_offsite or link.uri.host and link.uri.host!=@base_host ? nil : l
					}.compact
				if links.size>0 then
					print "\tI'm going to click a link!\n"
					@page = @agent.click links[rand(links.size-1)]
				else
					@page = @agent.back
					if @page==nil then
						raise OutOfLinks
					end	
				end
			end
			
		end
		
	end	
end