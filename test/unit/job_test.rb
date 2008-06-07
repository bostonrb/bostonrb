require File.dirname(__FILE__) + '/../test_helper'

class JobTest < ActiveSupport::TestCase
  should_require_attributes :title, :location, :organization, :description
  
  context 'Job finders' do
    setup do
      Factory(:job)
    end
    
    context 'Job#all' do
      setup do
        @jobs = Job.all
      end
      
      should "return all gigs" do
        assert Job.find(:all).all? {|job| @jobs.include?(job)}
      end
    end
  end
  
end
