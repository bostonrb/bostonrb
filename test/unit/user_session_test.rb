require File.dirname(__FILE__) + '/../test_helper'

class UserSessionTest < ActiveSupport::TestCase
  
  context 'A new UserSession' do
    setup do
      @job = Factory :job
      @user_session = UserSession.new Hash.new
    end

    should 'not be able to edit job' do
      assert_equal false, @user_session.edit_job?(@job)
    end
    
    context 'when a job id is added' do
      setup do
        @user_session.add_job @job
      end

      should 'be able to edit job' do
        assert @user_session.edit_job?(@job)
      end
      
      should 'have a editing time remaining greater than 0' do
        assert @user_session.editing_time_remaining(@job) > 0.minutes
      end
      
      context 'and 15 minutes pass' do
        setup do
          @job.update_attribute :created_at, 16.minutes.ago
        end

        should 'not be able to edit job' do
          assert_equal false, @user_session.edit_job?(@job)
        end
      end
    end
  end
  
end
