require 'spec_helper'

describe MeetupsHelper do

  describe ".project_night_link_path" do
    it "returns nothing if the meetup is nil" do
      Meetup.delete_all
      meetup = Meetup.last
      expect(helper.project_night_link_path(meetup)).to eql nil
    end
    it "returns a sign up required link if the meetup exists" do
      meetup = Meetup.new(project_night_url: "http://www.greg.com")
      expect(helper.project_night_link_path(meetup)).to include('Sign up required',
              meetup.project_night_url)
    end
  end

  describe ".meeting_link_path" do
    it "returns nothing if the meetup is nil" do
      Meetup.delete_all
      meetup = Meetup.last
      expect(helper.meeting_link_path(meetup)).to eql nil
    end
    it "returns a sign up required link if the meetup exists" do
      meetup = Meetup.new(meeting_url: "http://www.greg.com")
      expect(helper.meeting_link_path(meetup)).to include('Sign up required',
                meetup.meeting_url)
    end
  end

end
