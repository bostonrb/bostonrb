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
  end

  describe '#embed_video' do
    before { @presentation = Presentation.new(:vimeo_id => "123") }
    it 'embeds the video' do
      @presentation.embed_video.should == <<-HTML
<iframe src="http://player.vimeo.com/video/123" width="625" height="370" frameborder="0"></iframe>
    HTML
    end
  end
end
