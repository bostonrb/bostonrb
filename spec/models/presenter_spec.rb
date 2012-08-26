require 'spec_helper'

describe Presenter do
  it { should have_valid(:name).when('Test Name') }
  it { should_not have_valid(:name).when(nil, '') }

  describe '.group_by_score' do
    before do
      @presenter_1 = create(:presenter, :name => 'George Washington')
      @presenter_2 = create(:presenter)
      @presenter_3 = create(:presenter, :name => 'Abraham Lincoln')
      @presenter_4 = create(:presenter)
      @presentation_1 = create(:presentation, :presenter => @presenter_1)
      @presentation_2 = create(:presentation, :presenter => @presenter_2)
      @presentation_3 = create(:presentation, :presenter => @presenter_1)
      @presentation_4 = create(:presentation, :presenter => @presenter_3)
      @presentation_5 = create(:presentation, :presenter => @presenter_3)
      @presentation_6 = create(:presentation, :presenter => @presenter_3, :presented_at => 1.day.from_now)
      @presentation_7 = create(:presentation, :presenter => @presenter_4, :presented_at => 1.day.from_now)
    end

    it 'groups the presenters by the number of presentations given and sorts by name.' do
      expected = { 2 => [@presenter_3, @presenter_1], 1 => [@presenter_2] }
      Presenter.group_by_score.should == expected
    end
  end
end
