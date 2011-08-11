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
      @presentation_1 = Factory(:presentation, :presenter => @presenter_1)
      @presentation_2 = Factory(:presentation, :presenter => @presenter_2)
      @presentation_3 = Factory(:presentation, :presenter => @presenter_1)
      @presentation_4 = Factory(:presentation, :presenter => @presenter_3)
      @presentation_5 = Factory(:presentation, :presenter => @presenter_3)
      @presentation_6 = Factory(:presentation, :presenter => @presenter_3, :presented_at => 1.day.from_now)
      @presentation_7 = Factory(:presentation, :presenter => @presenter_4, :presented_at => 1.day.from_now)
    end

    it 'groups the presenters by the number of presentations given and sorts by name.' do
      expected = { 2 => [@presenter_3, @presenter_1], 1 => [@presenter_2] }
      Presenter.group_by_score.should == expected
    end
  end
end
