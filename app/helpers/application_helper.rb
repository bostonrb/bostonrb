module ApplicationHelper
  def upcoming_presentations
    @grouped_presentations = Presentation.upcoming.group_by_date(:asc)

    if @grouped_presentations.present?
      render :partial => 'pages/upcoming'
    end
  end

  def next_event
    if @next_event = Rails.cache.read(:next_event)
      render :partial => 'pages/next_event'
    end
  end
end
