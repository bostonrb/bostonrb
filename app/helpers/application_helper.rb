module ApplicationHelper
  def upcoming_presentations
    presentations = Presentation.upcoming
    @grouped_presentations = presentations.group_by_date(:asc)
    if @grouped_presentations.present?
      render :partial => 'pages/upcoming'
    end
  end
end
