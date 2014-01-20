require 'spec_helper'

describe UserSession  do

  before(:each) do
    @user_session = UserSession.new(true, false)
  end

  it 'returned a hash with permissions set' do
    permissions_hash = {organizer:true, project_night_coordinator:false}
    expect(@user_session.to_hash).to eql(permissions_hash)
  end

end
