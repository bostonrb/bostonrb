require 'spec_helper'

# describe '#new' do
#   context "no params passed" do
#     @clientclient_class.new
#     it 'has no client' do
#       @
#     end
#   end
#   context ''

# end

describe 'GithubAuth' do
  before do
    class Client
      def initialize(access_t)
      end

      def org_member?(one, two)
        true
      end

      def team_member?(one, two)
        true
      end

      def user
        self
      end

      def login
        'true'
      end
    end
    fake_params = { 'credentials' => {'token'=> 'yay'}}
    @test = GithubAuth.new(fake_params, Client)
  end

  it 'can call is_member' do
    expect(@test.is_member?).to eql(true)
  end

  it 'can call assign_team' do
    expect(@test.assign_team).to eql("organizer")
  end
end

