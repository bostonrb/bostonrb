require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_have_many :commits
  should_have_markup :description, :cache_html => true
  
  context 'Project.download_entries' do
    setup do
      @old_count = Commit.count :all
      Project.download_entries
    end

    should_eventually 'create Commits' do
      assert Commit.count(:all) > @old_count
    end
  end
  
end
