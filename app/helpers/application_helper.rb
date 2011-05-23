module ApplicationHelper
  def upcoming_presentations
    @grouped_presentations = Presentation.upcoming.group_by_date(:asc)
    if @grouped_presentations.present?
      render :partial => 'pages/upcoming'
    end
  end
end
