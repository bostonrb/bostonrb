require 'spec_helper'

describe MeetupsHelper do

  describe "meetup_path" do
    context "when a project night" do
      it "returns nothing if the meetup is nil" do
        ProjectNight.delete_all
        meetup = ProjectNight.last
        expect(helper.meetup_path(meetup)).to eql nil
      end
      it "returns a sign up required link if the meetup exists" do
        meetup = ProjectNight.new(url: "http://www.greg.com")
        expect(helper.meetup_path(meetup)).to include('Sign up required',
                meetup.url)
      end
    end
    context "when a meeting" do
      it "returns nothing if the meetup is nil" do
        MonthlyMeeting.delete_all
        meetup = MonthlyMeeting.last
        expect(helper.meetup_path(meetup)).to eql nil
      end
      it "returns a sign up required link if the meetup exists" do
        meetup = MonthlyMeeting.new(url: "http://www.greg.com")
        expect(helper.meetup_path(meetup)).to include('Sign up required',
                  meetup.url)
      end
    end
  end

end
