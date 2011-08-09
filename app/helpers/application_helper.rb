module ApplicationHelper
  def upcoming_presentations
    @grouped_presentations = Presentation.upcoming.group_by_date(:asc)
    if @grouped_presentations.present?
      render :partial => 'pages/upcoming'
    end
  end

  def next_event
    @next_event = BostonRbCalendar.next_event

    render :partial => 'pages/next_event'
  end
end
