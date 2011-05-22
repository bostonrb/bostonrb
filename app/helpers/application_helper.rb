module ApplicationHelper
  def upcoming_presentations
    @presentations = Presentation.upcoming
    if @presentations.present?
      @next_meeting_date = @presentations.first.presented_at.strftime("%B %d")
      render :partial => 'pages/upcoming'
    end
  end
end
