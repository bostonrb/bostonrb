require 'spec_helper'

describe Presentation do
  describe 'Validations' do
    it { should_not have_valid(:title).when(nil, '') }
    it { should_not have_valid(:description).when(nil, '') }
    it { should_not have_valid(:slides_url).when('badurl') }
    it { should     have_valid(:slides_url).when(nil, '', 'http://slides.com/1') }
    it { should_not have_valid(:presented_at).when(nil, '') }
    it { should_not have_valid(:presenter_name).when(nil, '') }
  end

  describe '.past' do
    before do
      Timecop.freeze(Date.parse('May 10, 2011'))
      @past_presentation_1  = Factory(:presentation, :presented_at => 'April 8, 2011')
      @past_presentation_2  = Factory(:presentation, :presented_at => 'May 9, 2011')
      @current_presentation = Factory(:presentation, :presented_at => 'May 10, 2011')
      @future_presentation  = Factory(:presentation, :presented_at => 'June 11, 2011')
    end

    after { Timecop.return }

    it 'will only return past presentations' do
      Presentation.past.should == [@past_presentation_2, @past_presentation_1]
    end

    it 'can take paginator params' do
      Presentation.past(:page => 1, :per => 1).should == [@past_presentation_2]
    end

    it 'can scope to a specific month' do
      Presentation.past(:month => 'May-2011').should == [@past_presentation_2]
    end
  end

  describe '.upcoming' do
    before do
      Timecop.freeze(Date.parse('February 10, 2011'))
      @presentation_1 = Factory(:presentation, :presented_at => 'January 8, 2011')
      @presentation_2 = Factory(:presentation, :presented_at => 'February 10, 2011')
      @presentation_3 = Factory(:presentation, :presented_at => 'March 5, 2011')
      @presentation_4 = Factory(:presentation, :presented_at => 'March 11, 2011')
    end

    after { Timecop.return }

    it 'should only return presentations belonging to the next monthly meeting' do
      Presentation.upcoming.should == [@presentation_2, @presentation_3]
    end
  end

  describe '.group_by_date' do
    before do
      @date_1 = Date.parse("May 10, 2011")
      @date_2 = Date.parse("April 12, 2011")
      @presentation_1 = Factory(:presentation, :presented_at => @date_1)
      @presentation_2 = Factory(:presentation, :presented_at => @date_2)
    end

    it 'returns an ordered grouping' do
      Presentation.group_by_date.should == {
        @date_1 => [@presentation_1],
        @date_2 => [@presentation_2]
      }
    end

    it 'returns an ordered grouping reversed' do
      Presentation.group_by_date(:asc).should == {
        @date_2 => [@presentation_2],
        @date_1 => [@presentation_1]
      }
    end
  end

  describe 'video' do
    context 'vimeo' do
      subject { Presentation.new(:video_url => 'http://vimeo.com/123') }
      its(:video_provider) { should == 'vimeo' }
      its(:video_id) { should == '123' }
      its(:embed_video) { should == %{<iframe src="http://player.vimeo.com/video/123" width="625" height="370" frameborder="0"></iframe>} }
    end
    context 'youtube' do
      subject { Presentation.new(:video_url => 'http://www.youtube.com/watch?v=123abc') }
      its(:video_provider) { should == 'youtube' }
      its(:video_id) { should == '123abc' }
      its(:embed_video) { should == %{<iframe width="625" height="370" src="http://www.youtube.com/embed/123abc" frameborder="0" allowfullscreen></iframe>} }
    end
    context 'blip' do
      # Blip.tv url must be taken from the embed code
      # The regular video URL cannot be easily translated to embed code style
      subject { Presentation.new(:video_url => 'http://blip.tv/play/123abc') }
      its(:video_provider) { should == 'blip' }
      its(:video_id) { should == '123abc' }
      its(:embed_video) { should == %{<embed src="http://blip.tv/play/123abc" type="application/x-shockwave-flash" width="625" height="370" allowscriptaccess="always" allowfullscreen="true"></embed>} }
    end
  end

end
