require 'spec_helper'

describe Presenter do
  it { should have_valid(:name).when('Test Name') }
  it { should_not have_valid(:name).when(nil, '') }

  describe '.group_by_score' do
    before do
      @presenter_1 = Factory(:presenter, :name => 'George Washington')
      @presenter_2 = Factory(:presenter)
      @presenter_3 = Factory(:presenter, :name => 'Abraham Lincoln')
      @presenter_4 = Factory(:presenter)
      @presenter_5 = Factory(:presenter, :name => 'George Lucas')
      @presentation_1 = Factory(:presentation, :presenter_name => @presenter_1.name)
      @presentation_2 = Factory(:presentation, :presenter_name => @presenter_2.name)
      @presentation_3 = Factory(:presentation, :presenter_name => @presenter_1.name)
      @presentation_4 = Factory(:presentation, :presenter_name => @presenter_3.name)
      @presentation_5 = Factory(:presentation, :presenter_name => @presenter_3.name)
      @presentation_6 = Factory(:presentation, :presenter_name => @presenter_3.name, :presented_at => 1.day.from_now)
      @presentation_7 = Factory(:presentation, :presenter_name => @presenter_4.name, :presented_at => 1.day.from_now)
      @presentation_8 = Factory(:presentation, :presenter_name => "George Washington & Abraham Lincoln")
      @presentation_9 = Factory(:presentation, :presenter_name => "George Washington, Abraham Lincoln")
      @presentation_9 = Factory(:presentation, :presenter_name => "George Washington, Abraham Lincoln & George Lucas")
    end

    it 'groups the presenters by the number of presentations given and sorts by name.' do
      expected = { 5 => [@presenter_3, @presenter_1], 1 => [@presenter_5, @presenter_2] }
      Presenter.group_by_score.should == expected
    end
  end
end
