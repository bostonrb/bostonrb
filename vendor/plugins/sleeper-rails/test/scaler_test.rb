require 'test_helper'
require 'shoulda'

ENV['FAKE_WEBAPP'] = '1'

class PostedSomeStuff < Exception; end

module Net
	class HTTP
		def self.post_form(url, content)
			content # pong
		end
	end
end

class ScalerTest < Test::Unit::TestCase

	context 'sleeper configured to pull things off the internet' do
		should 'pull down a config' do
		end
	end

	context 'sleeper config a manual configuration of everything off' do
		setup do
			Scaler.init({
				:sleeper_host=>'http://localhost',
				:log=>STDOUT,
				:client_key=>'foobar',
	        	:debug => true,
	        	:benchmarking => false,
	        	:explaining => false,
	        	:traces => false,
	        	:profiling => false,
	        	:peeking => false,
	      	}
			)
			
			@request = stub({:request_uri=>'test'})
			@controller = stub({
				:request=>@request,
				:action_name=>'test_action',
				:controller_name=>'test_controller_name',
				'ssl?'=>false,
				:port=>'interwebs_port',
				:remote_addr=>'bigtruck.com'
			})
		end
			
		should 'post some basic data and have sane results' do
			Scaler.statistics.add_to_this_request({:foo=>'bar'})
			Scaler.statistics.finish_request!(@controller)
			Scaler.statistics.gather_host_data
			posted_data = Scaler.statistics.upload!
			results = ActiveSupport::JSON.decode(posted_data['data'])
			
			# has sane load averages
			assert results['load_average'].match(/^(\d+.\d+\w?)+/)
			
			# has all the awesome info about locations & actions & what-not
			assert results['requests'].size==1
			assert results['requests'].first['action']=='test_action'
			assert results['requests'].first['url']=='test'
			assert results['requests'].first['foo']=='bar'
			assert results['requests'].first['controller']=='test_controller_name'
			
			# has sane some free_memory infos
			assert results['free_memory']
		end
		
		should 'gracefully handle timeouts' do
		end
		
		context 'with explainer turned on' do
			should 'explain sql statements' do
			end
		end
		
		context 'with profiler turned on' do
			should 'profile some code that I run' do
			end
		end
		
		context 'with benchmarking turned on' do
			should 'benchmark an actioncontroller request' do
			end
		end
		
		
		teardown do
			
		end
	end

end