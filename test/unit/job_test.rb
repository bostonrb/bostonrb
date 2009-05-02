require 'test_helper'

class JobTest < ActiveSupport::TestCase

  should_validate_presence_of :title, :location, :organization
  should_have_markup :description, :required => true, :cache_html => true

  context 'given a Job' do
    setup { Factory(:job) }

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
