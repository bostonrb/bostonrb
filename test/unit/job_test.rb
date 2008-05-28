require File.dirname(__FILE__) + '/../test_helper'

class JobTest < ActiveSupport::TestCase
  should_require_attributes :title, :location, :organization, :description
  
  context 'Job finders' do
    setup do
      create_fulltime_job
      create_gig_job
    end
    
    context 'Job#gigs' do
      setup do
        @jobs = Job.gigs
      end
      should "return only gigs" do
        assert @jobs.all? {|job| job.gig}
      end
    end
    
    context 'Job#full_time' do
      setup do
        @jobs = Job.full_time
      end
      should 'return only full time' do
        assert @jobs.all? {|job| !job.gig}
      end
    end
  end
  
end
