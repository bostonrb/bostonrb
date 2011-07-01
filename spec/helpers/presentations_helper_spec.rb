require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PresentationsHelper. For example:
#
# describe PresentationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe PresentationsHelper do
  describe '#presentations_index_header' do
    it "prints 'Past presentations' when no month is specific" do
      helper.presentations_index_header.should == 'Past presentations'
    end

    it 'prints specific month when specified' do
      controller.params[:month] = 'June-2011'
      helper.presentations_index_header.should == 'June 2011'
    end
  end
end
