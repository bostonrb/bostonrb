require 'spec_helper'

describe Meetup do
  describe 'Validations' do
    it { should_not have_valid(:project_night_url).when(nil, '') }
    it { should_not have_valid(:meeting_url).when(nil, '') }
    it { should_not have_valid(:project_night_url).when('foo', 'www.example.com') }
    it { should_not have_valid(:meeting_url).when('foo', 'www.example.com') }
    it { should have_valid(:project_night_url).when('http://www.google.com', 'https://www.google.com') }
    it { should have_valid(:meeting_url).when('http://www.google.com', 'https://www.google.com') }
  end

end
