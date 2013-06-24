require 'spec_helper'

describe MonthlyMeeting do
  describe 'Validations' do
    it { should_not have_valid(:url).when(nil, '') }
    it { should_not have_valid(:url).when('foo', 'www.example.com') }
    it { should have_valid(:url).when('http://www.google.com', 'https://www.google.com') }
  end

end
