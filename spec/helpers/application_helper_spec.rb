require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PresentationsHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do
  describe '#link_to_unless_current_with_span' do
    it "creates the anchor tag if it's not on the current page" do
      self.stubs(:current_page?).returns(false)
      html = link_to_unless_current_with_span('foo', presentations_path)
      html.should == "<a href=\"#{presentations_path}\">foo</a>"
    end

    it "uses the name wrapped in a <span> if it is the current page" do
      self.stubs(:current_page?).returns(true)
      html = link_to_unless_current_with_span('foo', presentations_path)
      html.should == "<span>foo</span>"
    end
  end

  describe '#page_title' do
    it 'returns the default page title if one is not provided by the view' do
      helper.page_title.should == 'Ruby and Ruby on Rails Meetings, Project Nights, and Community'
    end

    it 'returns the page title content provided' do
      helper.content_for(:page_title, 'Testing a custom page title')
      helper.page_title.should == 'Testing a custom page title'
    end
  end
end
